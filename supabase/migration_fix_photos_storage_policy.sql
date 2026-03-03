-- Migration: Fix photos storage bucket policies
-- Run this in Supabase SQL Editor
--
-- IMPORTANT: After running this migration, go to Supabase Dashboard > Storage > photos bucket
-- and set it to PRIVATE (toggle off "Public bucket"). This ensures that public URLs
-- no longer work and all access goes through signed URLs for authenticated users only.
--
-- Photos are only viewable by signed-in users. The app generates 24-hour signed URLs
-- for approved photos and 1-hour signed URLs for pending photos.

-- Set the bucket to private (disables public URL access for all files)
UPDATE storage.buckets
SET public = false
WHERE id = 'photos';

-- Drop any existing overly-permissive policies
DROP POLICY IF EXISTS "Public read photos" ON storage.objects;
DROP POLICY IF EXISTS "Allow public read" ON storage.objects;
DROP POLICY IF EXISTS "Public access" ON storage.objects;

-- Allow authenticated users to read any photo (pending, approved, or approved-edited)
CREATE POLICY "Authenticated users can read photos"
  ON storage.objects FOR SELECT
  USING (
    bucket_id = 'photos'
    AND auth.role() = 'authenticated'
  );

-- Allow authenticated users to upload photos (admins editing/cropping, public submissions)
CREATE POLICY "Authenticated users can upload photos"
  ON storage.objects FOR INSERT
  WITH CHECK (
    bucket_id = 'photos'
    AND auth.role() = 'authenticated'
  );

-- Allow authenticated users to delete photos (admins removing old versions)
CREATE POLICY "Authenticated users can delete photos"
  ON storage.objects FOR DELETE
  USING (
    bucket_id = 'photos'
    AND auth.role() = 'authenticated'
  );

-- Allow authenticated users to update photo metadata
CREATE POLICY "Authenticated users can update photos"
  ON storage.objects FOR UPDATE
  USING (
    bucket_id = 'photos'
    AND auth.role() = 'authenticated'
  );
