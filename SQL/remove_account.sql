UPDATE users
  SET 
    username = NULL, 
    password_hash = NULL, 
    sign_up = NULL, 
    last_login = NULL 
  WHERE username = ?username;
