/*
  # Create posts table with RLS policies

  1. New Tables
    - `posts`
      - `id` (uuid, primary key)
      - `created_at` (timestamp)
      - `title` (text, required)
      - `slug` (text, unique, required)
      - `excerpt` (text)
      - `content` (text)
      - `category` (text)
      - `tags` (text array)
      - `image` (text)
      - `author_name` (text)
      - `author_avatar` (text)
      - `author_bio` (text)
      - `read_time` (integer, default 5)
      - `featured` (boolean, default false)

  2. Security
    - Enable RLS on `posts` table
    - Add policies for public read access
    - Add policies for authenticated user CRUD operations

  3. Performance
    - Add indexes for common queries
*/

-- Create the posts table
CREATE TABLE IF NOT EXISTS posts (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  created_at timestamptz DEFAULT now(),
  title text NOT NULL,
  slug text NOT NULL UNIQUE,
  excerpt text,
  content text,
  category text,
  tags text[],
  image text,
  author_name text,
  author_avatar text,
  author_bio text,
  read_time integer DEFAULT 5,
  featured boolean DEFAULT false
);

-- Enable Row Level Security
ALTER TABLE posts ENABLE ROW LEVEL SECURITY;

-- Drop existing policies if they exist to avoid conflicts
DROP POLICY IF EXISTS "Posts are publicly readable" ON posts;
DROP POLICY IF EXISTS "Authenticated users can create posts" ON posts;
DROP POLICY IF EXISTS "Authenticated users can update posts" ON posts;
DROP POLICY IF EXISTS "Authenticated users can delete posts" ON posts;

-- Create policies
CREATE POLICY "Posts are publicly readable"
  ON posts
  FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Authenticated users can create posts"
  ON posts
  FOR INSERT
  TO authenticated
  WITH CHECK (true);

CREATE POLICY "Authenticated users can update posts"
  ON posts
  FOR UPDATE
  TO authenticated
  USING (true)
  WITH CHECK (true);

CREATE POLICY "Authenticated users can delete posts"
  ON posts
  FOR DELETE
  TO authenticated
  USING (true);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS posts_created_at_idx ON posts(created_at DESC);
CREATE INDEX IF NOT EXISTS posts_category_idx ON posts(category);
CREATE INDEX IF NOT EXISTS posts_featured_idx ON posts(featured);