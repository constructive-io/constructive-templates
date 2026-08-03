-- Revert: schemas/myapp_auth_private/tables/auth_user_devices/columns/is_trusted/column


ALTER TABLE myapp_auth_private.auth_user_devices 
  DROP COLUMN is_trusted RESTRICT;


