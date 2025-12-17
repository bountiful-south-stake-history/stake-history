# Quick Fix: Portrait Upload Error

## Error Message
"Could not find the 'portrait_submission_notes' column of 'people' in the schema cache (Code: PGRST204)"

## Solution

The database migration hasn't been run yet. The `people` table is missing the portrait-related columns.

### Steps to Fix:

1. **Open Supabase Dashboard**
   - Go to your Supabase project dashboard
   - Navigate to **SQL Editor**

2. **Run the Migration**
   - Copy the contents of `supabase/migration_add_portrait_fields.sql`
   - Paste into the SQL Editor
   - Click **Run** (or press Ctrl+Enter)

3. **Verify the Migration**
   - After running, check that the columns were added:
   ```sql
   SELECT column_name 
   FROM information_schema.columns 
   WHERE table_name = 'people' 
   AND column_name LIKE 'portrait%';
   ```
   - You should see:
     - `portrait_url`
     - `portrait_pending`
     - `portrait_uploaded_at`
     - `portrait_uploaded_by`
     - `portrait_submission_notes`
     - `portrait_approved_at`

4. **Try Upload Again**
   - Refresh your browser
   - Attempt the portrait upload again

## Migration SQL (for reference)

```sql
ALTER TABLE people
ADD COLUMN IF NOT EXISTS portrait_url TEXT,
ADD COLUMN IF NOT EXISTS portrait_pending BOOLEAN DEFAULT FALSE,
ADD COLUMN IF NOT EXISTS portrait_uploaded_at TIMESTAMPTZ,
ADD COLUMN IF NOT EXISTS portrait_uploaded_by UUID REFERENCES auth.users(id),
ADD COLUMN IF NOT EXISTS portrait_submission_notes TEXT,
ADD COLUMN IF NOT EXISTS portrait_approved_at TIMESTAMPTZ;
```

## Note

The storage bucket is correctly configured (you confirmed it exists and is public). Once you run this migration, the upload should work!

