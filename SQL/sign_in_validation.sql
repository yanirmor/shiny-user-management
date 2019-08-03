SELECT username, color
FROM user_management
WHERE is_enabled = 'y'
  AND username = ?username
  AND password = ?password;
