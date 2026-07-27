-- Revert: schemas/myapp_auth_private/tables/auth_user_devices/constraints/auth_user_devices_pkey/constraint


ALTER TABLE myapp_auth_private.auth_user_devices 
  DROP CONSTRAINT auth_user_devices_pkey;


