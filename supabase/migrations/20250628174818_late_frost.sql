/*
  # Create posts table for blog functionality

  1. New Tables
    - `posts`
      - `id` (uuid, primary key)
      - `created_at` (timestamp with time zone, default now())
      - `title` (text, not null)
      - `slug` (text, unique, not null)
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
    - Add policy for public read access
    - Add policy for authenticated users to manage posts
*/

CREATE TABLE IF NOT EXISTS posts (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  created_at timestamptz DEFAULT now(),
  title text NOT NULL,
  slug text UNIQUE NOT NULL,
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

ALTER TABLE posts ENABLE ROW LEVEL SECURITY;

-- Allow public read access to posts
CREATE POLICY "Posts are publicly readable"
  ON posts
  FOR SELECT
  TO public
  USING (true);

-- Allow authenticated users to insert posts
CREATE POLICY "Authenticated users can create posts"
  ON posts
  FOR INSERT
  TO authenticated
  WITH CHECK (true);

-- Allow authenticated users to update posts
CREATE POLICY "Authenticated users can update posts"
  ON posts
  FOR UPDATE
  TO authenticated
  USING (true)
  WITH CHECK (true);

-- Allow authenticated users to delete posts
CREATE POLICY "Authenticated users can delete posts"
  ON posts
  FOR DELETE
  TO authenticated
  USING (true);

-- Insert sample data
INSERT INTO posts (title, slug, excerpt, content, category, tags, image, author_name, author_avatar, author_bio, read_time, featured) VALUES
(
  'Introduction to Nuxt 3: The Future of Vue.js Development',
  'introduction-to-nuxt-3',
  'Discover the power of Nuxt 3 and how it revolutionizes Vue.js development with its new architecture, improved performance, and developer experience.',
  '# Introduction to Nuxt 3

Nuxt 3 represents a significant leap forward in Vue.js development, offering a modern, performant, and developer-friendly framework for building web applications.

## Key Features

### Auto-imports
Nuxt 3 automatically imports Vue components, composables, and utilities, reducing boilerplate code and improving developer experience.

### Server-Side Rendering
Built-in SSR support provides better SEO and faster initial page loads.

### TypeScript Support
First-class TypeScript support with zero configuration required.

## Getting Started

```bash
npx nuxi@latest init my-app
cd my-app
npm install
npm run dev
```

## Conclusion

Nuxt 3 is a powerful framework that makes Vue.js development more enjoyable and productive.',
  'Technology',
  ARRAY['Vue.js', 'Nuxt', 'JavaScript', 'Web Development'],
  'https://images.pexels.com/photos/11035380/pexels-photo-11035380.jpeg?auto=compress&cs=tinysrgb&w=800',
  'Sarah Johnson',
  'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=100',
  'Full-stack developer with expertise in Vue.js and Node.js',
  8,
  true
);