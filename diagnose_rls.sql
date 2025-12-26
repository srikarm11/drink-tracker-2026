-- Diagnostic Script for RLS Issue
-- Run this in Supabase SQL Editor to check your setup

-- 1. Check if user_id column exists and its type
SELECT 
    column_name, 
    data_type, 
    is_nullable,
    column_default
FROM information_schema.columns 
WHERE table_name = 'drinks' 
AND column_name = 'user_id';

-- 2. Check if RLS is enabled
SELECT 
    tablename,
    rowsecurity as rls_enabled
FROM pg_tables 
WHERE schemaname = 'public' 
AND tablename = 'drinks';

-- 3. List all RLS policies on drinks table
SELECT 
    schemaname,
    tablename,
    policyname,
    permissive,
    roles,
    cmd,
    qual,
    with_check
FROM pg_policies 
WHERE tablename = 'drinks';

-- 4. Check current authenticated user (run this while logged into your app)
-- This will show what auth.uid() returns for your current session
-- Note: You need to be authenticated in your app for this to work
SELECT 
    auth.uid() as current_auth_uid,
    auth.email() as current_auth_email;

-- 5. Check if there are any drinks with user_id set
SELECT 
    COUNT(*) as total_drinks,
    COUNT(DISTINCT user_id) as unique_users,
    COUNT(*) FILTER (WHERE user_id IS NULL) as null_user_ids
FROM drinks;

