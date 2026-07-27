-- Revert: schemas/myapp_auth_private/tables/auth_user_devices/policies/enable_row_level_security


ALTER TABLE myapp_auth_private.auth_user_devices 
  DISABLE ROW LEVEL SECURITY;


