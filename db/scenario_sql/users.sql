-- Scenario Positif
  -- Berdasarkan sudut pandaang kebutuhan client, 
    -- sehingga mengembalikan response/field yang dibutuhkan saja
  -- name scenario harus jelaskan sedetailnya
  -- Positif saja karena ini menentukan bussines requimenent, negatif dapat dicari dari turunannya

-- /users
  -- GET : Get all users to know who is registered
  SELECT id, username, f_name, l_name, profile_pic_url, created_at FROM users;
  -- GET : Get data demografi (gender, age)
  SELECT id, gender, birthdate, created_at FROM users;
  -- POST : Create a new user with complete data + key salt random
  INSERT INTO users (
    slug, username, f_name, m_name, l_name, email, phone, bio, birthdate, gender, profile_pic_url, bg_pic_url, current_pass_hash ) VALUES ()
  -- POST : Create a new user with complete data + key salt personalized
  INSERT INTO users (
    slug, username, f_name, m_name, l_name, email, phone, bio, birthdate, gender, profile_pic_url, bg_pic_url, current_pass_hash, pass_salt ) VALUES ()
  -- POST : Create a new user with only the required data + key salt random
  INSERT INTO users (
    slug, username, gender, current_pass_hash ) VALUES ()
  -- POST : Create a new user with only the required data + key salt personalized
  INSERT INTO users (
    slug, username, gender, current_pass_hash, pass_salt ) VALUES ()

-- /users/{user_id}
-- GET : Get user by id for user page view 
SELECT id, username, created_at, f_name, m_name, l_name, email, phone, bio, birthdate, gender,profile_pic_url, bg_pic_url FROM users WHERE id = 1;
-- GET : Get slug user by id 
SELECT id, username, created_at, slug FROM users WHERE id=1;
-- GET : Get fullname user by id 
SELECT id, username, created_at, f_name, m_name, l_name FROM users WHERE id=1;
-- GET : Get contact user by id 
SELECT id, username, created_at, email, phone FROM users WHERE id=1;
-- GET : Get user by id to celebrate their birthday 
SELECT id, username, created_at, birthdate FROM users WHERE id=1;
-- GET : Get picture user by id 
SELECT id, username, created_at, profile_pic_url, bg_pic_url FROM users WHERE id=1;
-- GET : Get password user by id 
SELECT id, username, created_at, current_pass_hash, last_updated_pass_at FROM users WHERE id=1;



------------------------------------------------------------------------------------------------
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