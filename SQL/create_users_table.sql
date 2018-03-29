CREATE TABLE users (
  id              SERIAL PRIMARY KEY,
  username        varchar(12) UNIQUE,
  password_hash   varchar(64),
  sign_up         timestamp,
  last_login      timestamp
);
