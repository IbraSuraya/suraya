CREATE TABLE IF NOT EXISTS users (
  id          SERIAL,
  slug        VARCHAR(50) NOT NULL,
  username    VARCHAR(20) NOT NULL UNIQUE,
  f_name      VARCHAR(20),
  m_name      VARCHAR(20),
  l_name      VARCHAR(20),
  email       VARCHAR(30),
  phone       VARCHAR(20),
  bio         TEXT,
  birthdate   DATE,
  gender      BOOLEAN NOT NULL,
  profile_pic_url  VARCHAR(255),
  bg_pic_url  VARCHAR(255),
  created_at  TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at  TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  deleted_at  TIMESTAMP WITH TIME ZONE,
  current_pass_hash     VARCHAR(255) NOT NULL,
  before_pass_hash      VARCHAR(255) NOT NULL DEFAULT 'default',
  last_updated_pass_at  TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  pass_salt	            VARCHAR(255),
  PRIMARY KEY (id)
);