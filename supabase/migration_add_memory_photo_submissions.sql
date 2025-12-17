-- Migration: Add fields for public memory and photo submissions
-- Run this in Supabase SQL Editor
--
-- NOTE: Before running this migration, create a storage bucket named "photos" in Supabase Dashboard > Storage
-- The bucket should allow public uploads to the "photos/pending/" folder

-- Add submission fields to stories table
ALTER TABLE stories
ADD COLUMN IF NOT EXISTS submitter_name TEXT,
ADD COLUMN IF NOT EXISTS submitter_email TEXT,
ADD COLUMN IF NOT EXISTS submitter_phone TEXT,
ADD COLUMN IF NOT EXISTS relationship TEXT,
ADD COLUMN IF NOT EXISTS time_period TEXT,
ADD COLUMN IF NOT EXISTS approved BOOLEAN DEFAULT FALSE;

-- Add submission fields to media table
ALTER TABLE media
ADD COLUMN IF NOT EXISTS submitter_name TEXT,
ADD COLUMN IF NOT EXISTS submitter_email TEXT,
ADD COLUMN IF NOT EXISTS submitter_phone TEXT,
ADD COLUMN IF NOT EXISTS approximate_date TEXT,
ADD COLUMN IF NOT EXISTS event_context TEXT;

-- Update RLS policies to allow public read of approved stories/media
DROP POLICY IF EXISTS "Authenticated read stories" ON stories;
DROP POLICY IF EXISTS "Authenticated read media" ON media;

-- Public can read approved stories
CREATE POLICY "Public read approved stories" ON stories
    FOR SELECT USING (published = TRUE AND approved = TRUE);

-- Public can insert stories (submissions)
CREATE POLICY "Public insert stories" ON stories
    FOR INSERT WITH CHECK (TRUE);

-- Public can read approved media
CREATE POLICY "Public read approved media" ON media
    FOR SELECT USING (approved = TRUE AND redacted = FALSE);

-- Public can insert media (submissions)
CREATE POLICY "Public insert media" ON media
    FOR INSERT WITH CHECK (TRUE);

-- Create view to check if person has approved content
CREATE OR REPLACE VIEW people_with_content AS
SELECT DISTINCT p.id
FROM people p
WHERE 
    (p.portrait_url IS NOT NULL AND p.portrait_pending = FALSE)
    OR EXISTS (
        SELECT 1 FROM stories s
        JOIN story_people sp ON s.id = sp.story_id
        WHERE sp.person_id = p.id
        AND s.published = TRUE
        AND s.approved = TRUE
    )
    OR EXISTS (
        SELECT 1 FROM media m
        JOIN media_people mp ON m.id = mp.media_id
        WHERE mp.person_id = p.id
        AND m.approved = TRUE
        AND m.redacted = FALSE
    );

