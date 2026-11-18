import { createClient } from '@supabase/supabase-js';

const supabaseUrl = import.meta.env.PUBLIC_SUPABASE_URL || '';
const supabaseAnonKey = import.meta.env.PUBLIC_SUPABASE_ANON_KEY || '';

export const supabase = createClient(supabaseUrl, supabaseAnonKey);

export interface VideoItem {
  id: string;
  title: string;
  youtube_url: string;
  youtube_id: string;
  category: 'Vibe Coding' | 'AI Agent' | 'Tools' | 'Community';
  phase: 1 | 2 | 3 | 4;
  duration?: string;
  description?: string;
  prompt_notes?: string;
  views_count?: number;
  is_published: boolean;
  created_at: string;
}
