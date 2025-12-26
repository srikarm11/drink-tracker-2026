# Supabase Setup Guide for Authentication & Row Level Security

This guide will help you set up authentication and Row Level Security (RLS) in your Supabase project so that each user can only see and manage their own drinks.

## Step 1: Update the Database Schema

First, you need to add a `user_id` column to your `drinks` table if it doesn't already exist.

1. Go to your Supabase project dashboard: https://supabase.com/dashboard
2. Navigate to **SQL Editor** in the left sidebar
3. Run the following SQL to add the `user_id` column:

```sql
-- Add user_id column to drinks table (if it doesn't exist)
ALTER TABLE drinks 
ADD COLUMN IF NOT EXISTS user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE;

-- Create an index for better query performance
CREATE INDEX IF NOT EXISTS drinks_user_id_idx ON drinks(user_id);
```

## Step 2: Migrate Existing Data (Optional)

If you have existing drinks in your database that you want to keep, you'll need to assign them to a user. You can either:

**Option A: Delete existing data and start fresh**
```sql
-- WARNING: This will delete all existing drinks
TRUNCATE TABLE drinks;
```

**Option B: Assign existing drinks to a specific user**
```sql
-- Replace 'YOUR_USER_ID_HERE' with your actual user ID from auth.users
UPDATE drinks 
SET user_id = 'YOUR_USER_ID_HERE' 
WHERE user_id IS NULL;
```

To find your user ID:
1. Go to **Authentication** → **Users** in your Supabase dashboard
2. Copy the UUID of your user account

## Step 3: Enable Row Level Security (RLS)

Enable RLS on the `drinks` table:

```sql
-- Enable RLS on the drinks table
ALTER TABLE drinks ENABLE ROW LEVEL SECURITY;
```

## Step 4: Create RLS Policies

Create policies that allow users to:
- View only their own drinks
- Insert only their own drinks
- Update only their own drinks
- Delete only their own drinks

Run this SQL in the SQL Editor:

```sql
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
```

## Step 5: Make user_id Required for New Inserts

To ensure all new drinks have a user_id, you can add a NOT NULL constraint:

```sql
-- Make user_id required (only do this after migrating existing data)
ALTER TABLE drinks 
ALTER COLUMN user_id SET NOT NULL;
```

**Note:** Only run this after you've migrated or deleted existing data, otherwise it will fail.

## Step 6: Verify the Setup

1. Test that RLS is working:
   - Sign up with a new account in your app
   - Add some drinks
   - Sign out and sign in with a different account
   - You should only see drinks from the current account

2. Check the policies in Supabase:
   - Go to **Authentication** → **Policies** in your Supabase dashboard
   - You should see the 4 policies listed above for the `drinks` table

## Troubleshooting

### Issue: "new row violates row-level security policy"
- Make sure you've added the `user_id` column to your table
- Ensure you're setting `user_id` when inserting drinks (the app code does this automatically)
- Verify the RLS policies are created correctly

### Issue: Can't see any drinks after signing in
- Check that the `user_id` column exists and has data
- Verify RLS policies are enabled and created
- Check the browser console for any error messages

### Issue: Existing drinks disappeared
- This is expected if you enabled RLS before adding user_id to existing rows
- You'll need to either migrate existing data to a user or start fresh

## Security Notes

- RLS policies ensure that even if someone tries to bypass your app and query the database directly, they can only access their own data
- The `auth.uid()` function returns the UUID of the currently authenticated user
- All policies use this function to filter data by the authenticated user's ID

## Next Steps

Once you've completed these steps:
1. Test the authentication flow in your app
2. Create a test account and verify data isolation
3. Share the app with your friends - each will have their own account and data!

