BEGIN;

-- insert data dummy with salt, key_email, key_phone generated random
INSERT INTO users (
  slug, username, f_name, m_name, l_name, email_encrypt, key_email, phone_encrypt, key_phone, bio, birthdate, gender, profile_pic_url, bg_pic_url, current_pass_hash, before_pass_hash, pass_salt
) VALUES (
  'ibra-suraya',
  'ibrasuraya1',
  'ibra',
  'H.',
  'Suraya',
  'gA1mAXldkU4OL3zryUxLBvodNWsibdzFT4wKzvzlRu4/P8KMqHw=',         -- Email
  '2xIJio1iEr4p2Iwt4BuTUqQGnCWTh5X0zbnxAhk6vfpaeTpMcWeYy3ElNbI=',
  '4VAivyuDHKtPgd0DP8ZQ2xwXvyB5t+Jh7ptz+w==',    -- Phone
  'S2l/C4SULdOGu93meuXb4Z7W5iv3dd+Xkdu2wzvhervGDSaCWViThwn2BR4=',
  'Bio singkat tentang Ibra Suraya.',
  '1990-01-01',
  TRUE,  -- TRUE untuk laki-laki, FALSE untuk perempuan
  'http://example.com/profile.jpg',
  'http://example.com/background.jpg',
  '3cLb3UkvHNGaisd5M2+6hsA1j/HE5zgpa58CRIQ6FIQ=',
  '3cLb3UkvHNGaisd5M2+6hsA1j/HE5zgpa58CRIQ6FIQ=',
  'OZBCYqDfGrjYVcRmRjYDZA=='
);

-- insert data dummy with salt, key_email, key_phone generated random
INSERT INTO users (
  slug, username, f_name, m_name, l_name, email_encrypt, key_email, phone_encrypt, key_phone, bio, birthdate, gender, profile_pic_url, bg_pic_url, current_pass_hash, before_pass_hash, pass_salt
) VALUES (
  'ibra-suraya',
  'ibrasuraya2',
  'ibra',
  'H.',
  'Suraya',
  'gA1mAXldkU4OL3zryUxLBvodNWsibdzFT4wKzvzlRu4/P8KMqHw=',         -- Email
  '2xIJio1iEr4p2Iwt4BuTUqQGnCWTh5X0zbnxAhk6vfpaeTpMcWeYy3ElNbI=',
  '4VAivyuDHKtPgd0DP8ZQ2xwXvyB5t+Jh7ptz+w==',    -- Phone
  'S2l/C4SULdOGu93meuXb4Z7W5iv3dd+Xkdu2wzvhervGDSaCWViThwn2BR4=',
  'Bio singkat tentang Ibra Suraya.',
  '1990-01-01',
  TRUE,  -- TRUE untuk laki-laki, FALSE untuk perempuan
  'http://example.com/profile.jpg',
  'http://example.com/background.jpg',
  'eWuaZ73EtkkwDXF4wvbZSBeHkSBA+wYlg5UZSYLVvfw=',
  'eWuaZ73EtkkwDXF4wvbZSBeHkSBA+wYlg5UZSYLVvfw=',
  'EBp9gVw/gatWzVcPHl9sMg=='
);

-- insert data dummy with salt, key_email, key_phone generated random with only the required data
INSERT INTO users (
  slug, username, gender, current_pass_hash, before_pass_hash, pass_salt
) VALUES (
  'ibra-suraya',
  'ibrasuraya3',
  TRUE,  -- TRUE untuk laki-laki, FALSE untuk perempuan
  'gYkOICcmBYwXxIkuMX1uJXVkfF6MyHkrdcJLyNIUqZI=',
  'gYkOICcmBYwXxIkuMX1uJXVkfF6MyHkrdcJLyNIUqZI=',
  'hBrMd79QaUyxSU+hDphEmA=='
);

COMMIT;