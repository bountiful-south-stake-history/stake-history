-- Migration: Add optional photo_id to memories table
-- This allows memories to be linked to specific photos
-- Run this in Supabase SQL Editor

ALTER TABLE memories ADD COLUMN IF NOT EXISTS photo_id UUID REFERENCES photos(id) ON DELETE SET NULL;
CREATE INDEX IF NOT EXISTS idx_memories_photo_id ON memories (photo_id) WHERE photo_id IS NOT NULL;
