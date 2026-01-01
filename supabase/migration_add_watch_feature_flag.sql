-- Migration: Add has_seen_watch_feature flag to user_profiles
-- Run this in Supabase SQL Editor

ALTER TABLE user_profiles
ADD COLUMN IF NOT EXISTS has_seen_watch_feature BOOLEAN DEFAULT FALSE;
