-- Cleanup and Reset Script for Drinks Tracker
-- WARNING: This will delete data! Run at your own risk.

-- Step 1: Clear all drinks from the table
-- This deletes ALL drinks from ALL users
TRUNCATE TABLE drinks;

-- Alternative: If you only want to delete drinks for a specific user, use this instead:
-- DELETE FROM drinks WHERE user_id = 'YOUR_USER_ID_HERE';
-- (Replace YOUR_USER_ID_HERE with your actual user ID from auth.users)

-- Step 2: Verify the table is empty
SELECT COUNT(*) as total_drinks FROM drinks;
-- Should return 0

-- Step 3: Delete your user account
-- Go to Supabase Dashboard → Authentication → Users
-- Find your user and click the three dots (⋯) → Delete User
-- OR run this SQL (replace 'YOUR_EMAIL_HERE' with your email):
-- DELETE FROM auth.users WHERE email = 'YOUR_EMAIL_HERE';

-- Note: Deleting a user will also delete their drinks due to ON DELETE CASCADE
-- if the foreign key is set up correctly.

