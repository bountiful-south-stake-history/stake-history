-- Migration: Add building_id to photos and memories tables
-- This allows photos and memories to be associated with specific buildings

-- Add building_id to photos table
ALTER TABLE photos ADD COLUMN IF NOT EXISTS building_id TEXT;

-- Add building_id to memories table
ALTER TABLE memories ADD COLUMN IF NOT EXISTS building_id TEXT;

-- Add indexes for query performance
CREATE INDEX IF NOT EXISTS idx_photos_building_id ON photos (building_id) WHERE building_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_memories_building_id ON memories (building_id) WHERE building_id IS NOT NULL;
