# Troubleshooting Portrait Upload Issues

## Common Error Messages and Solutions

### "Storage upload failed: Bucket not found"
**Solution:** 
1. Go to Supabase Dashboard > Storage
2. Create a bucket named `portraits`
3. Set bucket to **Public** (or configure RLS policies)
4. Ensure the bucket allows uploads to the `portraits/pending/` folder

### "Storage upload failed: new row violates row-level security"
**Solution:**
1. Go to Supabase Dashboard > Storage > Policies
2. Create a policy for the `portraits` bucket:
   ```sql
   -- Allow public uploads to pending folder
   CREATE POLICY "Public upload portraits pending"
   ON storage.objects FOR INSERT
   WITH CHECK (
     bucket_id = 'portraits' 
     AND (storage.foldername(name))[1] = 'pending'
   );
   
   -- Allow public read access
   CREATE POLICY "Public read portraits"
   ON storage.objects FOR SELECT
   USING (bucket_id = 'portraits');
   ```

### "Database update failed: new row violates row-level security"
**Solution:**
1. Check RLS policies on the `people` table
2. Ensure there's a policy allowing updates:
   ```sql
   -- Allow public to update portrait fields
   CREATE POLICY "Public update portrait fields"
   ON people FOR UPDATE
   USING (true)
   WITH CHECK (true);
   ```
   Or more restrictively:
   ```sql
   CREATE POLICY "Public update portrait fields"
   ON people FOR UPDATE
   USING (true)
   WITH CHECK (
     -- Only allow updating portrait-related fields
     true
   );
   ```

### "Failed to upload portrait" (generic error)
**Check:**
1. Open browser console (F12) and look for detailed error messages
2. Verify environment variables are set:
   - `VITE_SUPABASE_URL` should be your full Supabase URL
   - `VITE_SUPABASE_ANON_KEY` should be your anon/public key
3. Check network tab for failed requests and their status codes
4. Verify the person record exists and is not redacted

## Debugging Steps

1. **Check Browser Console:**
   - Look for console.error messages with "Storage upload error" or "Database update error"
   - Note the exact error message and code

2. **Check Network Tab:**
   - Find the failed request (usually to `/storage/v1/object/portraits/...` or `/rest/v1/people`)
   - Check the response status code and error message
   - Common codes:
     - 401: Authentication issue
     - 403: Permission denied (RLS policy)
     - 404: Bucket or resource not found
     - 406: Not Acceptable (header/format issue)
     - 500: Server error

3. **Verify Storage Bucket:**
   - Bucket name must be exactly `portraits` (case-sensitive)
   - Bucket must exist in Supabase Dashboard > Storage
   - Check bucket policies allow uploads

4. **Verify Database:**
   - Ensure `people` table has the portrait fields (run migration if needed)
   - Check RLS policies allow updates
   - Verify the person ID exists in the database

## Testing the Upload Flow

1. Open browser DevTools (F12)
2. Go to Console tab
3. Attempt to upload a portrait
4. Look for log messages:
   - "Uploading to storage: ..."
   - "File uploaded successfully: ..."
   - "Updating people table with portrait URL: ..."
   - "People table updated successfully: ..."
5. If errors occur, they will be logged with details

## Quick Fixes

### If storage bucket doesn't exist:
```sql
-- This must be done in Supabase Dashboard > Storage
-- Create bucket manually, then set policies
```

### If RLS is blocking updates:
Temporarily disable RLS for testing (NOT recommended for production):
```sql
ALTER TABLE people DISABLE ROW LEVEL SECURITY;
-- Test upload
-- Then re-enable: ALTER TABLE people ENABLE ROW LEVEL SECURITY;
```

### If environment variables are missing:
Check `.env.local` file exists and contains:
```
VITE_SUPABASE_URL=https://your-project.supabase.co
VITE_SUPABASE_ANON_KEY=your-anon-key-here
```

