-- Fix Bountiful 7th Ward organized date.
-- The organization was seeded with 1942-03-22, but the ward was actually
-- organized from Bountiful 4th Ward on 16 March 1952 (matches the first
-- bishop's 1952 calling and the About page). This corrects the year shown
-- in the ward header subtitle ("Ward • Organized 1942" -> "... 1952").

UPDATE organizations
SET organized_date = '1952-03-16'
WHERE name = 'Bountiful 7th Ward';
