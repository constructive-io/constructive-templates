-- Revert: schemas/myapp_auth_private/tables/auth_user_devices/columns/created_at/alterations/alt0000000001


ALTER TABLE myapp_auth_private.auth_user_devices 
  ALTER COLUMN created_at DROP DEFAULT;


