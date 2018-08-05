UPDATE user_management 
  SET last_login = ?last_login 
  WHERE username = ?username;
