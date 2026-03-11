-- Migration: Expand memories relationship check constraint to include building relationship types
-- Run this in Supabase SQL Editor

-- Drop the existing constraint
ALTER TABLE memories DROP CONSTRAINT memories_relationship_check;

-- Re-create with both person and building relationship values
ALTER TABLE memories ADD CONSTRAINT memories_relationship_check
  CHECK (relationship IN (
    'family', 'friend', 'served_together', 'ward_member',
    'attended', 'helped_build', 'grew_up', 'served_callings',
    'other'
  ));
