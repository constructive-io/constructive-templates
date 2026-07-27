-- Revert: schemas/myapp_auth_private/tables/auth_user_devices/columns/device_token_hash/column


ALTER TABLE myapp_auth_private.auth_user_devices 
  DROP COLUMN device_token_hash RESTRICT;


