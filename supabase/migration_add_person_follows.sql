-- Migration: Add person_follows table for Follow system
-- Run this in Supabase SQL Editor

CREATE TABLE IF NOT EXISTS person_follows (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    person_id UUID NOT NULL REFERENCES people(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(user_id, person_id)
);

CREATE INDEX IF NOT EXISTS idx_person_follows_user ON person_follows(user_id);
CREATE INDEX IF NOT EXISTS idx_person_follows_person ON person_follows(person_id);

ALTER TABLE person_follows ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view their own follows" ON person_follows
    FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own follows" ON person_follows
    FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can delete their own follows" ON person_follows
    FOR DELETE USING (auth.uid() = user_id);
