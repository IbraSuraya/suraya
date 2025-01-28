-- Scenario Positif
  -- Berdasarkan sudut pandaang kebutuhan client, 
    -- sehingga mengembalikan response/field yang dibutuhkan saja
  -- name scenario harus jelaskan sedetailnya
  -- Positif saja karena ini menentukan bussines requimenent, negatif dapat dicari dari turunannya

-- [BELUM ADA FITUR LOGIN]
  -- Sehingga tidak ada pengecekan login logout, auth, athorization

------------------------------------------------------------------------------------------------
-- select record with column completed
SELECT * FROM users;

-- /users 
  -- GET : Get all users to know who is registered
  SELECT id, username, f_name, l_name, profile_pic_url, created_at, updated_at FROM users;
  -- GET : Get data demografi (gender, age)
  SELECT id, usermame, gender, birthdate, created_at, updated_at FROM users;
  -- POST : Create a new user with complete data
  INSERT INTO users (
    username, f_name, m_name, l_name, email_encrypt, key_email, phone_encrypt, key_phone, bio, birthdate, gender, profile_pic_url, bg_pic_url, current_pass_hash, before_pass_hash, pass_salt ) VALUES ()
  -- POST : Create a new user with only the required data
  INSERT INTO users (
    username, gender, current_pass_hash, before_pass_hash, pass_salt ) VALUES ()

-- /users/{user_id}
-- GET
  -- GET : Get user by id for user page view 
  SELECT id, username, created_at, f_name, m_name, l_name, email_encrypt, key_email, phone_encrypt, key_phone, bio, birthdate, gender,profile_pic_url, bg_pic_url FROM users WHERE id = 1;
  -- GET : Get slug user by id 
  SELECT id, username, created_at, slug FROM users WHERE id=1;
  -- GET : Get fullname user by id 
  SELECT id, username, created_at, f_name, m_name, l_name FROM users WHERE id=1;
  -- GET : Get contact user by id 
  SELECT id, username, created_at, email_encrypt, key_email, phone_encrypt, key_phone FROM users WHERE id=1;
  -- GET : Get user by id to celebrate their birthday 
  SELECT id, username, created_at, birthdate FROM users WHERE id=1;
  -- GET : Get picture user by id 
  SELECT id, username, created_at, profile_pic_url, bg_pic_url FROM users WHERE id=1;
  -- GET : Get password user by id 
  SELECT id, username, created_at, current_pass_hash, last_updated_pass_at, pass_salt FROM users WHERE id=1;
  -- GET : Get password user by id for page change password 
  SELECT id, username, created_at, current_pass_hash, last_updated_pass_at, pass_salt, before_pass_hash FROM users WHERE id=1;
-- PUT
  -- PUT : Replace all data users
  UPDATE users SET 
    username = 'ibrasuraya100', f_name = 'ibraU', m_name = 'hasanU', l_name = 'surayaU', email_encrypt = 'emailU', key_email = 'key_email_U', phone_encrypt = 'phoneU', key_phone = 'key_phone_U', bio = 'bioU', birthdate = '1999-12-30', gender = FALSE, profile_pic_url = 'pp_U', bg_pic_url = 'bg_U', current_pass_hash = 'current_pass_U', before_pass_hash = current_pass_hash, pass_salt = 'saltU', updated_at = NOW(), last_updated_pass_at = NOW() WHERE id=3;
  -- Just check before pass is work
  UPDATE users SET 
    username = 'ibrasuraya101', f_name = 'ibraU1', m_name = 'hasanU1', l_name = 'surayaU1', email_encrypt = 'emailU1', key_email = 'key_email_U1', phone_encrypt = 'phoneU1', key_phone = 'key_phone_U1', bio = 'bioU1', birthdate = '1999-12-30', gender = FALSE, profile_pic_url = 'pp_U1', bg_pic_url = 'bg_U1', current_pass_hash = 'current_pass_U1', before_pass_hash = current_pass_hash, pass_salt = 'saltU1', updated_at = NOW(), last_updated_pass_at = NOW() WHERE id=3;
-- PATCH
  -- PATCH : update password user by id
  UPDATE users SET 
    current_pass_hash = 'current_pass_U2', before_pass_hash = current_pass_hash, pass_salt = 'saltU2', last_updated_pass_at = NOW() WHERE id=3;
  -- PATCH : update username user by id
  UPDATE users SET 
    username = 'ibrasuraya', updated_at = NOW() WHERE id=3;
  -- PATCH : update fullname user by id
  UPDATE users SET 
    f_name = 'Ibra', m_name = 'Hasan', l_name = 'Suraya', updated_at = NOW() WHERE id=3;
  -- PATCH : update contact user by id
  UPDATE users SET 
    email_encrypt = 'email', key_email = 'key_email', phone_encrypt = 'phone', key_phone = 'key_phone', updated_at = NOW() WHERE id=3;
  -- PATCH : update bio user by id
  UPDATE users SET 
    bio = 'bio', updated_at = NOW() WHERE id=3;
  -- PATCH : update birthdate user by id
  UPDATE users SET 
    birthdate = '1990-01-01', updated_at = NOW() WHERE id=3;
  -- PATCH : update gender user by id
  UPDATE users SET 
    gender = TRUE, updated_at = NOW() WHERE id=3;
  -- PATCH : update profile_pic_url user by id
  UPDATE users SET 
    profile_pic_url = 'pp', updated_at = NOW() WHERE id=3;
  -- PATCH : update bg_pic_url user by id
  UPDATE users SET 
    bg_pic_url = 'bg', updated_at = NOW() WHERE id=3;
-- DELETE
  -- DELETE : soft delete
  UPDATE users SET 
    deleted_at = NOW(), updated_at = NOW() WHERE id=3;
  -- DELETE : permanen delete
  DELETE FROM users WHERE id=3;

------------------------------------------------------------------------------------------------

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