-- Schema for Tự Học AI Agent & Vibe Coding

-- 1. Categories table
CREATE TABLE IF NOT EXISTS categories (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL UNIQUE,
  slug TEXT NOT NULL UNIQUE,
  description TEXT,
  sort_order INT DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Videos table
CREATE TABLE IF NOT EXISTS videos (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title TEXT NOT NULL,
  youtube_url TEXT NOT NULL,
  youtube_id TEXT NOT NULL,
  category_id UUID REFERENCES categories(id) ON DELETE SET NULL,
  phase INT DEFAULT 1 CHECK (phase BETWEEN 1 AND 4),
  duration TEXT,
  description TEXT,
  prompt_notes TEXT, -- Tài liệu & Prompts đính kèm
  views_count INT DEFAULT 0,
  is_featured BOOLEAN DEFAULT FALSE,
  is_published BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 3. Row Level Security (RLS)
ALTER TABLE categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE videos ENABLE ROW LEVEL SECURITY;

-- Everyone can read published videos
CREATE POLICY "Public videos are viewable by everyone" 
  ON videos FOR SELECT 
  USING (is_published = true);

-- Everyone can read categories
CREATE POLICY "Categories are viewable by everyone" 
  ON categories FOR SELECT 
  USING (true);

-- Authenticated admins can insert/update/delete
CREATE POLICY "Admins have full access to videos" 
  ON videos FOR ALL 
  TO authenticated 
  USING (true);

CREATE POLICY "Admins have full access to categories" 
  ON categories FOR ALL 
  TO authenticated 
  USING (true);

-- Seed initial categories
INSERT INTO categories (name, slug, sort_order) VALUES
  ('Vibe Coding Cơ Bản', 'vibe-coding', 1),
  ('Xây Dựng Ứng Dụng', 'web-apps', 2),
  ('AI Agent & Automation', 'ai-agent', 3),
  ('Tools & Prompts', 'tools-prompts', 4)
ON CONFLICT (slug) DO NOTHING;
