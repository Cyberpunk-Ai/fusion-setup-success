-- Storage access rules for the "media" bucket (path: <folder>/<profile_id>/<file>)
CREATE POLICY "media_public_read" ON storage.objects FOR SELECT TO public
  USING (bucket_id = 'media');
CREATE POLICY "media_owner_insert" ON storage.objects FOR INSERT TO authenticated
  WITH CHECK (bucket_id = 'media' AND (storage.foldername(name))[2] = public.current_profile_id());
CREATE POLICY "media_owner_update" ON storage.objects FOR UPDATE TO authenticated
  USING (bucket_id = 'media' AND (storage.foldername(name))[2] = public.current_profile_id())
  WITH CHECK (bucket_id = 'media' AND (storage.foldername(name))[2] = public.current_profile_id());
CREATE POLICY "media_owner_delete" ON storage.objects FOR DELETE TO authenticated
  USING (bucket_id = 'media' AND (storage.foldername(name))[2] = public.current_profile_id());

-- Starter profiles
INSERT INTO public.profiles (id, username, display_name, bio, avatar_url, location, website, followers, following, verified, plan) VALUES
('u_seed_maya',  'mayachen',   'Maya Chen',   'Product designer sketching the future of social. Coffee-fuelled.', 'https://i.pravatar.cc/200?img=47', 'Lisbon',   'https://maya.design', 12400, 312, true,  'pro'),
('u_seed_leo',   'leookafor',  'Leo Okafor',  'Indie dev. Building in public, one commit at a time.',            'https://i.pravatar.cc/200?img=12', 'Lagos',    'https://leo.dev',     8300,  540, true,  'plus'),
('u_seed_priya', 'priyanair',  'Priya Nair',  'Photographer & storyteller. Light chaser.',                        'https://i.pravatar.cc/200?img=32', 'Mumbai',   '',                    21900, 180, true,  'pro'),
('u_seed_sam',   'samrivera',  'Sam Rivera',  'Host of the Late Night Builders space. Ask me about audio.',       'https://i.pravatar.cc/200?img=59', 'Austin',   '',                    4100,  890, false, 'free'),
('u_seed_aisha', 'aishabello', 'Aisha Bello', 'Community lead. Here for the conversations.',                     'https://i.pravatar.cc/200?img=26', 'Nairobi',  '',                    6700,  420, false, 'plus');

-- Starter posts
INSERT INTO public.posts (id, user_id, content, media_url, image_gradient, tags, poll, created_at) VALUES
('p_seed_01', 'u_seed_maya',  'Welcome to Spaces! 👋 Share a moment, join a live room, or just lurk — we''re happy you''re here. What are you working on this week?', NULL, NULL, '["welcome","community"]', NULL, now() - interval '20 minutes'),
('p_seed_02', 'u_seed_priya', 'Golden hour over the harbour tonight. No filter, just patience. 🌅', 'https://picsum.photos/seed/spaces-harbour/1200/800', NULL, '["photography","goldenhour"]', NULL, now() - interval '1 hour'),
('p_seed_03', 'u_seed_leo',   'Shipped the new video player today — single progress rail, auto-hiding controls, pauses when you scroll past. Here''s a quick demo clip 🎬', 'https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4', NULL, '["buildinpublic","video"]', NULL, now() - interval '2 hours'),
('p_seed_04', 'u_seed_sam',   'Quick poll for tonight''s Late Night Builders space — what should we dig into?', NULL, NULL, '["spaces","poll"]', '{"id":"poll_seed_1","question":"Tonight''s topic?","options":[{"id":"o1","text":"Monetising a side project","votes":14},{"id":"o2","text":"Designing for mobile first","votes":9},{"id":"o3","text":"Audio rooms: what works?","votes":21}],"totalVotes":44}', now() - interval '3 hours'),
('p_seed_05', 'u_seed_aisha', 'Reminder: the best communities are built on small, consistent kindnesses. Reply to someone new today. 💜', NULL, 'from-violet-500 via-fuchsia-500 to-rose-400', '["community"]', NULL, now() - interval '5 hours'),
('p_seed_06', 'u_seed_maya',  'Design tip: your empty states are the first thing new users see. Treat them like a welcome mat, not an error message.', 'https://picsum.photos/seed/spaces-design/1200/800', NULL, '["design","ux"]', NULL, now() - interval '8 hours'),
('p_seed_07', 'u_seed_leo',   'Hot take: 80% of "performance work" is just deleting things. What did you delete this week?', NULL, NULL, '["dev","performance"]', NULL, now() - interval '1 day'),
('p_seed_08', 'u_seed_priya', 'Behind the scenes from this weekend''s street shoot. Rain makes everything better. 🌧️', 'https://picsum.photos/seed/spaces-street/1200/900', NULL, '["photography","streetphotography"]', NULL, now() - interval '2 days');

-- Comments
INSERT INTO public.comments (post_id, user_id, content, created_at) VALUES
('p_seed_01', 'u_seed_leo',   'Rebuilding my portfolio for the third time this year 😅', now() - interval '15 minutes'),
('p_seed_01', 'u_seed_aisha', 'Welcome everyone! Say hi below 👇', now() - interval '12 minutes'),
('p_seed_02', 'u_seed_maya',  'That light is unreal. What lens?', now() - interval '50 minutes'),
('p_seed_03', 'u_seed_sam',   'The scroll-to-pause is such a nice touch.', now() - interval '90 minutes'),
('p_seed_03', 'u_seed_priya', 'Finally a player that doesn''t fight me on mobile 🙌', now() - interval '80 minutes'),
('p_seed_07', 'u_seed_maya',  'Three onboarding modals. Zero regrets.', now() - interval '20 hours');

-- Likes
INSERT INTO public.likes (user_id, post_id) VALUES
('u_seed_leo','p_seed_01'),('u_seed_priya','p_seed_01'),('u_seed_sam','p_seed_01'),('u_seed_aisha','p_seed_01'),
('u_seed_maya','p_seed_02'),('u_seed_leo','p_seed_02'),('u_seed_sam','p_seed_02'),
('u_seed_maya','p_seed_03'),('u_seed_priya','p_seed_03'),('u_seed_aisha','p_seed_03'),
('u_seed_leo','p_seed_04'),('u_seed_maya','p_seed_05'),('u_seed_priya','p_seed_05'),('u_seed_leo','p_seed_06'),('u_seed_aisha','p_seed_07'),('u_seed_maya','p_seed_08');

-- Follows between seed creators
INSERT INTO public.follows (follower_id, target_id) VALUES
('u_seed_leo','u_seed_maya'),('u_seed_priya','u_seed_maya'),('u_seed_sam','u_seed_maya'),
('u_seed_maya','u_seed_leo'),('u_seed_aisha','u_seed_leo'),('u_seed_maya','u_seed_priya'),('u_seed_leo','u_seed_priya');

-- Stories (expire 24h from now)
INSERT INTO public.stories (id, user_id, type, gradient, media_url, text, caption, location, mood, stickers, expires_at, created_at) VALUES
('s_seed_01', 'u_seed_priya', 'image', NULL, 'https://picsum.photos/seed/spaces-story1/720/1280', NULL, 'Morning walk', 'Mumbai', '☕ Slow morning', '["✨"]', now() + interval '23 hours', now() - interval '40 minutes'),
('s_seed_02', 'u_seed_leo',   'image', NULL, 'https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4', NULL, 'Player demo', 'Lagos', '🎬 Shipping', '[]', now() + interval '22 hours', now() - interval '2 hours'),
('s_seed_03', 'u_seed_maya',  'gradient', 'from-amber-400 via-orange-500 to-rose-500', NULL, 'Ship small. Ship often. Ship kind.', NULL, 'Lisbon', '🔥 Focused', '["🚀","💜"]', now() + interval '20 hours', now() - interval '4 hours');

-- Spaces
INSERT INTO public.spaces (id, title, host_id, topic, listeners, live, gradient, recorded, duration, created_at) VALUES
('space_seed_live', 'Late Night Builders: audio rooms that actually work', 'u_seed_sam', 'Building', 128, true,  'from-brand to-brand-pink', false, NULL, now() - interval '30 minutes'),
('space_seed_rec',  'Designing empty states people love',                  'u_seed_maya', 'Design',  0,   false, 'from-violet-500 to-fuchsia-500', true, '42:10', now() - interval '3 days');
INSERT INTO public.space_participants (space_id, user_id, role) VALUES
('space_seed_live','u_seed_sam','host'),('space_seed_live','u_seed_leo','speaker'),('space_seed_live','u_seed_aisha','listener');