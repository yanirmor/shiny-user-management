UPDATE user_management
SET color = ?color
WHERE username = ?username
  AND is_enabled = 'y';
