-- Revert: schemas/myapp_auth_private/tables/auth_user_devices/columns/updated_at/alterations/alt0000000001


ALTER TABLE myapp_auth_private.auth_user_devices 
  ALTER COLUMN updated_at DROP DEFAULT;


