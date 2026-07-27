-- Revert: schemas/myapp_auth_private/tables/auth_user_devices/columns/user_agent/column


ALTER TABLE myapp_auth_private.auth_user_devices 
  DROP COLUMN user_agent RESTRICT;


