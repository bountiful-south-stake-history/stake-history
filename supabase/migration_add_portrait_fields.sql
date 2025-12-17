-- Migration: Add portrait upload fields to people table
-- Run this in Supabase SQL Editor before using portrait upload functionality

ALTER TABLE people
ADD COLUMN IF NOT EXISTS portrait_url TEXT,
ADD COLUMN IF NOT EXISTS portrait_pending BOOLEAN DEFAULT FALSE,
ADD COLUMN IF NOT EXISTS portrait_uploaded_at TIMESTAMPTZ,
ADD COLUMN IF NOT EXISTS portrait_uploaded_by UUID REFERENCES auth.users(id),
ADD COLUMN IF NOT EXISTS portrait_submission_notes TEXT,
ADD COLUMN IF NOT EXISTS portrait_approved_at TIMESTAMPTZ;

-- Create storage bucket for portraits (if it doesn't exist)
-- Note: This must be done in Supabase Dashboard > Storage
-- Bucket name: portraits
-- Public: Yes (or configure RLS policies as needed)

-- Storage policies (run after creating bucket):
-- Allow public read access to approved portraits
-- Allow authenticated users to upload to portraits/pending/ folder

