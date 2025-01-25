BEGIN;

-- insert data dummy with kode salt generated random
INSERT INTO users (
  slug, username, f_name, m_name, l_name, email, phone, bio, birthdate, gender, profile_pic_url, bg_pic_url, current_pass_hash
) VALUES (
  'ibra-suraya',
  'ibrasuraya1',
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
  crypt('currentpassword1', gen_salt('bf'))
);

-- insert data dummy with kode salt 'kodesalt'
INSERT INTO users (
  slug, username, f_name, m_name, l_name, email, phone, bio, birthdate, gender, profile_pic_url, bg_pic_url, current_pass_hash, pass_salt
) VALUES (
  'ibra-suraya',
  'ibrasuraya2',
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
  crypt('currentpassword2', 'kodesalt'),
  'kodesalt'
);

COMMIT;