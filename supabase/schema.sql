-- Stake History Database Schema
-- Bountiful Utah South Stake
-- Run this in Supabase SQL Editor

-- ============================================
-- ENUMS
-- ============================================

CREATE TYPE org_type AS ENUM ('stake', 'ward', 'branch', 'auxiliary');
CREATE TYPE position_type AS ENUM ('president', 'counselor', 'secretary', 'clerk', 'member', 'other');
CREATE TYPE date_precision AS ENUM ('exact', 'month', 'year');
CREATE TYPE story_type AS ENUM ('memory', 'recognition', 'memorial', 'historical');
CREATE TYPE media_type AS ENUM ('photo', 'document', 'audio');
CREATE TYPE user_role AS ENUM ('admin', 'contributor', 'viewer');

-- ============================================
-- CORE TABLES
-- ============================================

-- People table
CREATE TABLE people (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    full_name TEXT NOT NULL,
    display_name TEXT,
    suffix TEXT,
    birth_date DATE,
    death_date DATE,
    bio TEXT,
    photo_url TEXT,
    redacted BOOLEAN DEFAULT FALSE,
    redacted_at TIMESTAMPTZ,
    redacted_by UUID REFERENCES auth.users(id),
    redaction_reason TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Organizations table
CREATE TABLE organizations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    short_name TEXT,
    org_type org_type NOT NULL,
    parent_org_id UUID REFERENCES organizations(id),
    organized_date DATE,
    discontinued_date DATE,
    notes TEXT,
    sort_order INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Positions table
CREATE TABLE positions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title TEXT NOT NULL,
    short_title TEXT,
    position_type position_type NOT NULL,
    org_types org_type[] DEFAULT '{}',
    sort_order INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Callings table (the main junction)
CREATE TABLE callings (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    person_id UUID NOT NULL REFERENCES people(id) ON DELETE CASCADE,
    position_id UUID NOT NULL REFERENCES positions(id),
    organization_id UUID NOT NULL REFERENCES organizations(id),
    presidency_number INTEGER,
    sustained_date DATE NOT NULL,
    sustained_precision date_precision DEFAULT 'exact',
    released_date DATE,
    released_precision date_precision,
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================
-- USER PROFILES (extends Supabase auth)
-- ============================================

CREATE TABLE user_profiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    email TEXT,
    display_name TEXT,
    role user_role DEFAULT 'viewer',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================
-- MEDIA & STORIES (Phase 2)
-- ============================================

-- Media uploads
CREATE TABLE media (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    file_url TEXT NOT NULL,
    file_type media_type NOT NULL,
    caption TEXT,
    uploaded_by UUID REFERENCES auth.users(id),
    redacted BOOLEAN DEFAULT FALSE,
    approved BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Media to people junction
CREATE TABLE media_people (
    media_id UUID REFERENCES media(id) ON DELETE CASCADE,
    person_id UUID REFERENCES people(id) ON DELETE CASCADE,
    PRIMARY KEY (media_id, person_id)
);

-- Media to callings junction
CREATE TABLE media_callings (
    media_id UUID REFERENCES media(id) ON DELETE CASCADE,
    calling_id UUID REFERENCES callings(id) ON DELETE CASCADE,
    PRIMARY KEY (media_id, calling_id)
);

-- Stories/Memories
CREATE TABLE stories (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title TEXT NOT NULL,
    content TEXT NOT NULL,
    story_type story_type NOT NULL,
    author_id UUID REFERENCES auth.users(id),
    published BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Stories to people junction
CREATE TABLE story_people (
    story_id UUID REFERENCES stories(id) ON DELETE CASCADE,
    person_id UUID REFERENCES people(id) ON DELETE CASCADE,
    PRIMARY KEY (story_id, person_id)
);

-- Stories time period (optional date range)
CREATE TABLE story_time_periods (
    story_id UUID REFERENCES stories(id) ON DELETE CASCADE,
    start_date DATE,
    end_date DATE,
    PRIMARY KEY (story_id)
);

-- ============================================
-- AUDIT LOG
-- ============================================

CREATE TABLE audit_log (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    table_name TEXT NOT NULL,
    record_id UUID NOT NULL,
    action TEXT NOT NULL,
    old_values JSONB,
    new_values JSONB,
    performed_by UUID REFERENCES auth.users(id),
    performed_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================
-- INDEXES
-- ============================================

CREATE INDEX idx_people_full_name ON people(full_name);
CREATE INDEX idx_people_redacted ON people(redacted);
CREATE INDEX idx_callings_person ON callings(person_id);
CREATE INDEX idx_callings_org ON callings(organization_id);
CREATE INDEX idx_callings_dates ON callings(sustained_date, released_date);
CREATE INDEX idx_organizations_type ON organizations(org_type);
CREATE INDEX idx_organizations_parent ON organizations(parent_org_id);

-- ============================================
-- ROW LEVEL SECURITY (RLS)
-- ============================================

ALTER TABLE people ENABLE ROW LEVEL SECURITY;
ALTER TABLE organizations ENABLE ROW LEVEL SECURITY;
ALTER TABLE positions ENABLE ROW LEVEL SECURITY;
ALTER TABLE callings ENABLE ROW LEVEL SECURITY;
ALTER TABLE media ENABLE ROW LEVEL SECURITY;
ALTER TABLE stories ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_profiles ENABLE ROW LEVEL SECURITY;

-- Public read access for non-redacted core data
CREATE POLICY "Public read people" ON people
    FOR SELECT USING (redacted = FALSE);

CREATE POLICY "Public read organizations" ON organizations
    FOR SELECT USING (TRUE);

CREATE POLICY "Public read positions" ON positions
    FOR SELECT USING (TRUE);

CREATE POLICY "Public read callings" ON callings
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM people 
            WHERE people.id = callings.person_id 
            AND people.redacted = FALSE
        )
    );

-- Admin full access
CREATE POLICY "Admin full access people" ON people
    FOR ALL USING (
        EXISTS (
            SELECT 1 FROM user_profiles 
            WHERE user_profiles.id = auth.uid() 
            AND user_profiles.role = 'admin'
        )
    );

CREATE POLICY "Admin full access organizations" ON organizations
    FOR ALL USING (
        EXISTS (
            SELECT 1 FROM user_profiles 
            WHERE user_profiles.id = auth.uid() 
            AND user_profiles.role = 'admin'
        )
    );

CREATE POLICY "Admin full access callings" ON callings
    FOR ALL USING (
        EXISTS (
            SELECT 1 FROM user_profiles 
            WHERE user_profiles.id = auth.uid() 
            AND user_profiles.role = 'admin'
        )
    );

-- Stories visible only to authenticated users
CREATE POLICY "Authenticated read stories" ON stories
    FOR SELECT USING (
        auth.uid() IS NOT NULL AND published = TRUE
    );

-- Media visible only to authenticated users (if approved)
CREATE POLICY "Authenticated read media" ON media
    FOR SELECT USING (
        auth.uid() IS NOT NULL AND approved = TRUE AND redacted = FALSE
    );

-- User profiles
CREATE POLICY "Users read own profile" ON user_profiles
    FOR SELECT USING (auth.uid() = id);

CREATE POLICY "Admin read all profiles" ON user_profiles
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM user_profiles up
            WHERE up.id = auth.uid() 
            AND up.role = 'admin'
        )
    );

-- ============================================
-- FUNCTIONS
-- ============================================

-- Update timestamp trigger
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Apply to tables
CREATE TRIGGER update_people_updated_at
    BEFORE UPDATE ON people
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER update_organizations_updated_at
    BEFORE UPDATE ON organizations
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER update_callings_updated_at
    BEFORE UPDATE ON callings
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER update_stories_updated_at
    BEFORE UPDATE ON stories
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- Function to handle new user signup
CREATE OR REPLACE FUNCTION handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO user_profiles (id, email, display_name, role)
    VALUES (
        NEW.id,
        NEW.email,
        COALESCE(NEW.raw_user_meta_data->>'display_name', split_part(NEW.email, '@', 1)),
        'viewer'
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger for new user signup
CREATE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW EXECUTE FUNCTION handle_new_user();

-- ============================================
-- VIEWS FOR COMMON QUERIES
-- ============================================

-- Person with calling count
CREATE VIEW people_with_stats AS
SELECT 
    p.*,
    COUNT(c.id) as calling_count,
    MIN(c.sustained_date) as first_calling,
    MAX(COALESCE(c.released_date, CURRENT_DATE)) as last_calling
FROM people p
LEFT JOIN callings c ON p.id = c.person_id
WHERE p.redacted = FALSE
GROUP BY p.id;

-- Current callings (no release date)
CREATE VIEW current_callings AS
SELECT 
    c.*,
    p.full_name as person_name,
    pos.title as position_title,
    o.name as organization_name
FROM callings c
JOIN people p ON c.person_id = p.id
JOIN positions pos ON c.position_id = pos.id
JOIN organizations o ON c.organization_id = o.id
WHERE c.released_date IS NULL
AND p.redacted = FALSE;

-- ============================================
-- SEED DATA: Positions
-- ============================================

INSERT INTO positions (title, short_title, position_type, sort_order) VALUES
-- Stake Leadership
('Stake President', 'President', 'president', 1),
('1st Counselor', '1st', 'counselor', 2),
('2nd Counselor', '2nd', 'counselor', 3),
('Stake Executive Secretary', 'Exec Sec', 'secretary', 4),
('Stake Clerk', 'Clerk', 'clerk', 5),
('Assistant Stake Clerk', 'Asst Clerk', 'clerk', 6),
('Stake Patriarch', 'Patriarch', 'other', 7),
('High Councilor', 'HC', 'member', 8),

-- Ward/Branch Leadership
('Bishop', 'Bishop', 'president', 1),
('Branch President', 'President', 'president', 1),

-- Auxiliary Leadership
('President', 'President', 'president', 1),
('Superintendent', 'Supt', 'president', 1),
('Director', 'Director', 'president', 1),
('1st Assistant', '1st Asst', 'counselor', 2),
('2nd Assistant', '2nd Asst', 'counselor', 3),
('Assistant Counselor', 'Asst', 'counselor', 4),
('3rd Counselor', '3rd', 'counselor', 4),
('Laurel Advisor', 'Laurel Adv', 'other', 5),
('MIA Maid Advisor', 'MIA Maid Adv', 'other', 5),
('Beehive Advisor', 'Beehive Adv', 'other', 5);

-- ============================================
-- SEED DATA: Organizations
-- ============================================

-- Stake
INSERT INTO organizations (name, short_name, org_type, sort_order) VALUES
('Bountiful Utah South Stake', 'Stake', 'stake', 0);

-- Get stake ID for parent reference
DO $$
DECLARE
    stake_id UUID;
BEGIN
    SELECT id INTO stake_id FROM organizations WHERE name = 'Bountiful Utah South Stake';
    
    -- Stake Auxiliaries
    INSERT INTO organizations (name, short_name, org_type, parent_org_id, sort_order) VALUES
    ('Stake Presidency', 'Stake Presidency', 'auxiliary', stake_id, 1),
    ('High Council', 'High Council', 'auxiliary', stake_id, 2),
    ('Stake Executive Secretary', 'Exec Secretary', 'auxiliary', stake_id, 3),
    ('Stake Clerk', 'Stake Clerk', 'auxiliary', stake_id, 4),
    ('Assistant Stake Clerk', 'Asst Clerk', 'auxiliary', stake_id, 5),
    ('Stake Patriarch', 'Patriarch', 'auxiliary', stake_id, 6),
    ('Stake Relief Society', 'Stake RS', 'auxiliary', stake_id, 10),
    ('Stake Young Men', 'Stake YM', 'auxiliary', stake_id, 11),
    ('Stake Young Women', 'Stake YW', 'auxiliary', stake_id, 12),
    ('Stake Primary', 'Stake Primary', 'auxiliary', stake_id, 13),
    ('Stake Sunday School', 'Stake SS', 'auxiliary', stake_id, 14),
    ('Stake Mission', 'Stake Mission', 'auxiliary', stake_id, 15);
    
    -- Wards
    INSERT INTO organizations (name, short_name, org_type, parent_org_id, organized_date, sort_order) VALUES
    ('Bountiful 4th Ward', '4th Ward', 'ward', stake_id, '1904-03-06', 20),
    ('Bountiful 7th Ward', '7th Ward', 'ward', stake_id, '1942-03-22', 21),
    ('Bountiful 14th Ward', '14th Ward', 'ward', stake_id, '1956-12-30', 22),
    ('Bountiful 15th Ward', '15th Ward', 'ward', stake_id, '1957-04-21', 23),
    ('Bountiful 20th Ward', '20th Ward', 'ward', stake_id, '1961-04-30', 24),
    ('Bountiful 25th Ward', '25th Ward', 'ward', stake_id, '1963-12-15', 25),
    ('Bountiful 36th Ward', '36th Ward', 'ward', stake_id, '1968-09-08', 26),
    ('Bountiful 39th Ward', '39th Ward', 'ward', stake_id, '1970-10-25', 27),
    ('Bountiful 57th Ward', '57th Ward', 'ward', stake_id, '1983-01-30', 28);
    
    -- Update 57th Ward as discontinued
    UPDATE organizations SET discontinued_date = '1992-03-15' 
    WHERE name = 'Bountiful 57th Ward';
    
    -- Branches
    INSERT INTO organizations (name, short_name, org_type, parent_org_id, organized_date, sort_order) VALUES
    ('Heritage Branch', 'Heritage', 'branch', stake_id, '1992-04-12', 40);
    
END $$;

-- ============================================
-- DONE! Now run the seed_callings.sql to import calling records
-- ============================================
