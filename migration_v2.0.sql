-- Migration script for v2.0: Enhanced Analytics and Drinks Database
-- Run this in Supabase SQL Editor

-- Add calories/cost to existing drinks table
ALTER TABLE drinks 
ADD COLUMN IF NOT EXISTS calories INTEGER,
ADD COLUMN IF NOT EXISTS cost DECIMAL(10,2),
ADD COLUMN IF NOT EXISTS serving_size TEXT;

-- Create public drinks database table (base drinks)
CREATE TABLE IF NOT EXISTS drinks_database (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  category TEXT NOT NULL CHECK (category IN ('Beer', 'Wine', 'Cocktail')),
  calories INTEGER,
  cost DECIMAL(10,2),
  serving_size TEXT,
  name_variations TEXT[] DEFAULT '{}',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Enable RLS on drinks_database (read-only for all authenticated users)
ALTER TABLE drinks_database ENABLE ROW LEVEL SECURITY;

-- Drop existing policy if it exists
DROP POLICY IF EXISTS "Anyone can read drinks_database" ON drinks_database;

CREATE POLICY "Anyone can read drinks_database" 
ON drinks_database FOR SELECT 
USING (true);

-- Create user custom drinks table
CREATE TABLE IF NOT EXISTS user_custom_drinks (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  category TEXT NOT NULL CHECK (category IN ('Beer', 'Wine', 'Cocktail')),
  calories INTEGER,
  cost DECIMAL(10,2),
  serving_size TEXT,
  name_variations TEXT[] DEFAULT '{}',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(user_id, name)
);

-- Enable RLS on user_custom_drinks
ALTER TABLE user_custom_drinks ENABLE ROW LEVEL SECURITY;

-- Drop existing policy if it exists
DROP POLICY IF EXISTS "Users can manage their own custom drinks" ON user_custom_drinks;

CREATE POLICY "Users can manage their own custom drinks" 
ON user_custom_drinks 
FOR ALL 
USING (auth.uid() = user_id);

-- Note: The drinks_database table will be populated separately using the seed data
-- See DRINKS_DATABASE_SEED in index.html for the initial data
