-- Migration: Add follow_activity table for tracking activity on watched people
-- Run this in Supabase SQL Editor

CREATE TABLE IF NOT EXISTS follow_activity (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    person_id UUID NOT NULL REFERENCES people(id) ON DELETE CASCADE,
    activity_type TEXT NOT NULL CHECK (activity_type IN ('photo_tag', 'memory')),
    photo_id UUID REFERENCES photos(id) ON DELETE CASCADE,
    memory_id UUID REFERENCES memories(id) ON DELETE CASCADE,
    title TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    CONSTRAINT check_activity_reference CHECK (
        (activity_type = 'photo_tag' AND photo_id IS NOT NULL AND memory_id IS NULL) OR
        (activity_type = 'memory' AND memory_id IS NOT NULL AND photo_id IS NULL)
    )
);

CREATE INDEX IF NOT EXISTS idx_follow_activity_person ON follow_activity(person_id);
CREATE INDEX IF NOT EXISTS idx_follow_activity_created ON follow_activity(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_follow_activity_photo ON follow_activity(photo_id) WHERE photo_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_follow_activity_memory ON follow_activity(memory_id) WHERE memory_id IS NOT NULL;

ALTER TABLE follow_activity ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view activity for people they watch" ON follow_activity
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM person_follows
            WHERE person_follows.person_id = follow_activity.person_id
            AND person_follows.user_id = auth.uid()
        )
    );

CREATE POLICY "Admins can insert activity" ON follow_activity
    FOR INSERT WITH CHECK (
        EXISTS (
            SELECT 1 FROM user_profiles
            WHERE user_profiles.id = auth.uid()
            AND user_profiles.role = 'admin'
        )
    );

CREATE POLICY "Admins can view all activity" ON follow_activity
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM user_profiles
            WHERE user_profiles.id = auth.uid()
            AND user_profiles.role = 'admin'
        )
    );
