/*
  # Create posts table for blog functionality

  1. New Tables
    - `posts`
      - `id` (uuid, primary key, auto-generated)
      - `created_at` (timestamp with timezone, defaults to now())
      - `title` (text, required)
      - `slug` (text, required, unique)
      - `excerpt` (text, optional)
      - `content` (text, optional)
      - `category` (text, optional)
      - `tags` (text array, optional)
      - `image` (text, optional)
      - `author_name` (text, optional)
      - `author_avatar` (text, optional)
      - `author_bio` (text, optional)
      - `read_time` (integer, defaults to 5)
      - `featured` (boolean, defaults to false)

  2. Security
    - Enable RLS on `posts` table
    - Add policy for public read access
    - Add policies for authenticated users to create, update, and delete posts

  3. Indexes
    - Unique index on slug for SEO-friendly URLs
    - Primary key on id
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