-- Revert: schemas/myapp_auth_private/tables/auth_user_devices/columns/created_at/column


ALTER TABLE myapp_auth_private.auth_user_devices 
  DROP COLUMN created_at RESTRICT;


