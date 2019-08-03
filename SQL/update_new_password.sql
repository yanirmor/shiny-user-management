UPDATE user_management
SET password = ?password
WHERE username = ?username
  AND is_enabled = 'y';
