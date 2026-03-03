-- Migration: Add suggestions table for user feedback
-- Run this in Supabase SQL Editor

CREATE TABLE IF NOT EXISTS suggestions (
  id               uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  suggestion       text NOT NULL,
  email            text,
  page_url         text,
  status           text NOT NULL DEFAULT 'new'
                     CHECK (status IN ('new', 'in_review', 'resolved', 'dismissed')),
  admin_notes      text,
  created_at       timestamptz NOT NULL DEFAULT now(),
  updated_at       timestamptz NOT NULL DEFAULT now()
);

-- updated_at auto-refresh on UPDATE
-- Note: update_updated_at() function already exists in schema.sql
CREATE TRIGGER set_suggestions_updated_at
  BEFORE UPDATE ON suggestions
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- Public can insert; only admins can read/update/delete
ALTER TABLE suggestions ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone can submit suggestions"
  ON suggestions FOR INSERT TO anon, authenticated
  WITH CHECK (true);

CREATE POLICY "Admins can view suggestions"
  ON suggestions FOR SELECT TO authenticated
  USING (
    EXISTS (SELECT 1 FROM user_profiles WHERE id = auth.uid() AND role = 'admin')
  );

CREATE POLICY "Admins can update suggestions"
  ON suggestions FOR UPDATE TO authenticated
  USING (
    EXISTS (SELECT 1 FROM user_profiles WHERE id = auth.uid() AND role = 'admin')
  );

CREATE POLICY "Admins can delete suggestions"
  ON suggestions FOR DELETE TO authenticated
  USING (
    EXISTS (SELECT 1 FROM user_profiles WHERE id = auth.uid() AND role = 'admin')
  );
