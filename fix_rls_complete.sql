-- Complete RLS Fix Script
-- Run this ENTIRE script in Supabase SQL Editor
-- This will fix the RLS policy issue

-- Step 1: Ensure user_id column exists with correct type
DO $$ 
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'drinks' AND column_name = 'user_id'
    ) THEN
        ALTER TABLE drinks 
        ADD COLUMN user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE;
        
        CREATE INDEX IF NOT EXISTS drinks_user_id_idx ON drinks(user_id);
        
        RAISE NOTICE 'user_id column created';
    ELSE
        RAISE NOTICE 'user_id column already exists';
    END IF;
END $$;

-- Step 2: Enable RLS
ALTER TABLE drinks ENABLE ROW LEVEL SECURITY;

-- Step 3: Drop ALL existing policies (clean slate)
DROP POLICY IF EXISTS "Users can view own drinks" ON drinks;
DROP POLICY IF EXISTS "Users can insert own drinks" ON drinks;
DROP POLICY IF EXISTS "Users can update own drinks" ON drinks;
DROP POLICY IF EXISTS "Users can delete own drinks" ON drinks;

-- Step 4: Create policies with explicit permissions
-- SELECT policy
CREATE POLICY "Users can view own drinks"
ON drinks
FOR SELECT
TO authenticated
USING (auth.uid() = user_id);

-- INSERT policy (this is the critical one!)
CREATE POLICY "Users can insert own drinks"
ON drinks
FOR INSERT
TO authenticated
WITH CHECK (auth.uid() = user_id);

-- UPDATE policy
CREATE POLICY "Users can update own drinks"
ON drinks
FOR UPDATE
TO authenticated
USING (auth.uid() = user_id)
WITH CHECK (auth.uid() = user_id);

-- DELETE policy
CREATE POLICY "Users can delete own drinks"
ON drinks
FOR DELETE
TO authenticated
USING (auth.uid() = user_id);

-- Step 5: Verify policies were created
SELECT 
    policyname, 
    cmd, 
    roles,
    qual,
    with_check
FROM pg_policies 
WHERE tablename = 'drinks'
ORDER BY policyname;

-- You should see 4 policies listed above
-- If you see 0 policies, something went wrong!

