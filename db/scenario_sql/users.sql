-- Scenario
  -- Berdasarkan sudut pandaang kebutuhan client, 
    -- sehingga mengembalikan response/field yang dibutuhkan saja
  -- name scenario harus jelaskan sedetailnya


-- Langunsg ajh scenario : GET all user with complate colmns

-- select record with column completed
SELECT * FROM users;
SELECT username, current_pass_hash, before_pass_hash, pass_salt FROM users;

-- Reset record
TRUNCATE TABLE users RESTART IDENTITY CASCADE;

-- VALIDASI PASSWORD without pass_salt
SELECT (current_pass_hash = crypt('1', current_pass_hash)) 
    AS password_match 
FROM users 
WHERE username = 'ibrasuraya1' ;
-- VALIDASI PASSWORD with pass_salt
SELECT (current_pass_hash = crypt('3', pass_salt)) 
    AS password_match 
FROM users 
WHERE username = 'ibrasuraya3' ;

-- SELECT with Verification
SELECT * FROM users 
WHERE username = 'ibrasuraya1' 
AND current_pass_hash = crypt('1', current_pass_hash);
SELECT * FROM users 
WHERE username = 'ibrasuraya3' 
AND current_pass_hash = crypt('3', pass_salt);

-- insert data dummy
INSERT INTO users (
  slug, username, f_name, m_name, l_name, email, phone, bio, birthdate, gender, profile_pic_url, bg_pic_url, current_pass_hash
  -- before_pass_hash, 
  -- pass_salt
) VALUES (
  'ibra-suraya',
  'ibrasuraya',
  'ibra',
  'H.',
  'Suraya',
  'ibrasuraya@example.com',
  '123-456-7890',
  'Bio singkat tentang Ibra Suraya.',
  '1990-01-01',
  TRUE,  -- TRUE untuk laki-laki, FALSE untuk perempuan
  'http://example.com/profile.jpg',
  'http://example.com/background.jpg',
  crypt('currentpassword', gen_salt('bf')),
  -- crypt('beforepassword', gen_salt('bf')),
  -- gen_salt('bf')
);

INSERT INTO users (
  slug, username, gender, current_pass_hash
) VALUES 
(
  'ibra-suraya',
  'ibrasuraya1',
  TRUE,
  crypt('1', gen_salt('bf',10))
),
(
  'ibra-suraya',
  'ibrasuraya2',
  TRUE,
  crypt('2', gen_salt('bf',10))
);
INSERT INTO users (
  slug, username, gender, current_pass_hash, pass_salt
) VALUES 
(
  'ibra-suraya',
  'ibrasuraya3',
  TRUE,
  crypt('3', 'kodesalt'),
  'kodesalt'
);