-- Revert: schemas/myapp_auth_private/tables/auth_user_devices/columns/user_id/alterations/alt0000000001


ALTER TABLE myapp_auth_private.auth_user_devices 
  ALTER COLUMN user_id DROP NOT NULL;


