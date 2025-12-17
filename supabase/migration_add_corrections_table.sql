-- Migration: Create corrections table for data correction submissions
-- Run this in Supabase SQL Editor

CREATE TYPE correction_type AS ENUM ('name_spelling', 'date_correction', 'other');

CREATE TABLE corrections (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    person_id UUID REFERENCES people(id) ON DELETE CASCADE,
    correction_type correction_type NOT NULL,
    description TEXT NOT NULL,
    submitter_name TEXT NOT NULL,
    submitter_email TEXT NOT NULL,
    submitter_phone TEXT,
    status TEXT DEFAULT 'pending' CHECK (status IN ('pending', 'reviewed', 'resolved', 'rejected')),
    reviewed_by UUID REFERENCES auth.users(id),
    reviewed_at TIMESTAMPTZ,
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_corrections_person ON corrections(person_id);
CREATE INDEX idx_corrections_status ON corrections(status);
CREATE INDEX idx_corrections_created ON corrections(created_at);

ALTER TABLE corrections ENABLE ROW LEVEL SECURITY;

-- Only admins can view corrections
CREATE POLICY "Admin read corrections" ON corrections
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM user_profiles 
            WHERE user_profiles.id = auth.uid() 
            AND user_profiles.role = 'admin'
        )
    );

-- Anyone can insert corrections (public submissions)
CREATE POLICY "Public insert corrections" ON corrections
    FOR INSERT WITH CHECK (TRUE);

-- Only admins can update corrections
CREATE POLICY "Admin update corrections" ON corrections
    FOR UPDATE USING (
        EXISTS (
            SELECT 1 FROM user_profiles 
            WHERE user_profiles.id = auth.uid() 
            AND user_profiles.role = 'admin'
        )
    );

-- Update timestamp trigger
CREATE TRIGGER update_corrections_updated_at
    BEFORE UPDATE ON corrections
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();

