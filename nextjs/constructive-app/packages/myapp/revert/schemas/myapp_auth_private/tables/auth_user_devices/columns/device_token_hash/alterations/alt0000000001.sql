-- Revert: schemas/myapp_auth_private/tables/auth_user_devices/columns/device_token_hash/alterations/alt0000000001


ALTER TABLE myapp_auth_private.auth_user_devices 
  ALTER COLUMN device_token_hash DROP NOT NULL;


