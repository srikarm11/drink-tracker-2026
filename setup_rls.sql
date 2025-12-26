-- Complete RLS Setup Script for Drinks Tracker
-- Run this entire script in your Supabase SQL Editor

-- Step 1: Add user_id column if it doesn't exist
ALTER TABLE drinks 
ADD COLUMN IF NOT EXISTS user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE;

-- Step 2: Create index for better performance
CREATE INDEX IF NOT EXISTS drinks_user_id_idx ON drinks(user_id);

-- Step 3: Drop existing policies if they exist (to avoid conflicts)
DROP POLICY IF EXISTS "Users can view own drinks" ON drinks;
DROP POLICY IF EXISTS "Users can insert own drinks" ON drinks;
DROP POLICY IF EXISTS "Users can update own drinks" ON drinks;
DROP POLICY IF EXISTS "Users can delete own drinks" ON drinks;

-- Step 4: Enable RLS (safe to run multiple times)
ALTER TABLE drinks ENABLE ROW LEVEL SECURITY;

-- Step 5: Create RLS Policies

-- Policy: Users can view only their own drinks
CREATE POLICY "Users can view own drinks"
ON drinks
FOR SELECT
USING (auth.uid() = user_id);

-- Policy: Users can insert only their own drinks
CREATE POLICY "Users can insert own drinks"
ON drinks
FOR INSERT
WITH CHECK (auth.uid() = user_id);

-- Policy: Users can update only their own drinks
CREATE POLICY "Users can update own drinks"
ON drinks
FOR UPDATE
USING (auth.uid() = user_id)
WITH CHECK (auth.uid() = user_id);

-- Policy: Users can delete only their own drinks
CREATE POLICY "Users can delete own drinks"
ON drinks
FOR DELETE
USING (auth.uid() = user_id);

-- Step 6: Verify setup (optional - this will show you the policies)
-- SELECT * FROM pg_policies WHERE tablename = 'drinks';

