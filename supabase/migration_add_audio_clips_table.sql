-- Migration: Create audio_clips table for archival audio recordings
-- Run this in Supabase SQL Editor

CREATE TABLE IF NOT EXISTS audio_clips (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    person_id UUID REFERENCES people(id) ON DELETE CASCADE,
    title TEXT NOT NULL,
    audio_url TEXT NOT NULL,
    event_context TEXT,
    approximate_date DATE,
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_audio_clips_person ON audio_clips(person_id);
CREATE INDEX IF NOT EXISTS idx_audio_clips_date ON audio_clips(approximate_date);

ALTER TABLE audio_clips ENABLE ROW LEVEL SECURITY;

-- Public read access to audio clips
CREATE POLICY "Public read audio clips" ON audio_clips
    FOR SELECT USING (TRUE);

-- Only admins can insert/update/delete audio clips
CREATE POLICY "Admin insert audio clips" ON audio_clips
    FOR INSERT WITH CHECK (
        EXISTS (
            SELECT 1 FROM user_profiles
            WHERE user_profiles.id = auth.uid()
            AND user_profiles.role = 'admin'
        )
    );

CREATE POLICY "Admin update audio clips" ON audio_clips
    FOR UPDATE USING (
        EXISTS (
            SELECT 1 FROM user_profiles
            WHERE user_profiles.id = auth.uid()
            AND user_profiles.role = 'admin'
        )
    );

CREATE POLICY "Admin delete audio clips" ON audio_clips
    FOR DELETE USING (
        EXISTS (
            SELECT 1 FROM user_profiles
            WHERE user_profiles.id = auth.uid()
            AND user_profiles.role = 'admin'
        )
    );

-- Update timestamp trigger
CREATE TRIGGER update_audio_clips_updated_at
    BEFORE UPDATE ON audio_clips
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();
