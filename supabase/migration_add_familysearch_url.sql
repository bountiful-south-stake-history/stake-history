-- Migration: Add familysearch_url to people table
-- Allows linking each person to their FamilySearch profile

ALTER TABLE people ADD COLUMN IF NOT EXISTS familysearch_url TEXT;
