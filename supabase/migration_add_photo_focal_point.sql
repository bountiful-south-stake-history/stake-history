-- Add focal point columns to photos table for preview positioning
-- This allows admins to control which part of the image is visible in thumbnails

ALTER TABLE photos ADD COLUMN IF NOT EXISTS focal_x INTEGER DEFAULT 50;
ALTER TABLE photos ADD COLUMN IF NOT EXISTS focal_y INTEGER DEFAULT 50;

-- Add comment explaining the columns
COMMENT ON COLUMN photos.focal_x IS 'Horizontal focal point percentage (0-100, left to right)';
COMMENT ON COLUMN photos.focal_y IS 'Vertical focal point percentage (0-100, top to bottom)';
