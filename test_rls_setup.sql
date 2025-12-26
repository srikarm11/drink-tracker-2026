-- Quick RLS Setup Verification
-- Run each query one at a time and share ALL results

-- Query 1: Check if user_id column exists
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'drinks' AND column_name = 'user_id';

-- Query 2: Check if RLS is enabled
SELECT tablename, rowsecurity 
FROM pg_tables 
WHERE schemaname = 'public' AND tablename = 'drinks';

-- Query 3: List ALL policies (this is critical!)
SELECT policyname, cmd, with_check 
FROM pg_policies 
WHERE tablename = 'drinks';

-- Query 4: Test what auth.uid() returns (run this while logged into your app)
SELECT auth.uid() as current_user_id, auth.email() as current_email;

