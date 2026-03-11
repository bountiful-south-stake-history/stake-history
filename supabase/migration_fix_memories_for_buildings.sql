-- Migration: Allow memories to be associated with buildings (no person_id required)
-- Run this in Supabase SQL Editor

-- Make person_id nullable so building memories don't need a person
ALTER TABLE memories ALTER COLUMN person_id DROP NOT NULL;

-- Ensure building_id column exists (idempotent)
ALTER TABLE memories ADD COLUMN IF NOT EXISTS building_id TEXT;

-- Create index for building_id lookups
CREATE INDEX IF NOT EXISTS idx_memories_building_id ON memories (building_id) WHERE building_id IS NOT NULL;

-- Ensure RLS allows authenticated users to insert memories
-- (Drop first to make idempotent)
DROP POLICY IF EXISTS "Authenticated users can insert memories" ON memories;
CREATE POLICY "Authenticated users can insert memories" ON memories
    FOR INSERT TO authenticated
    WITH CHECK (TRUE);

-- Ensure RLS allows reading approved memories
DROP POLICY IF EXISTS "Anyone can read approved memories" ON memories;
CREATE POLICY "Anyone can read approved memories" ON memories
    FOR SELECT USING (status = 'approved');
