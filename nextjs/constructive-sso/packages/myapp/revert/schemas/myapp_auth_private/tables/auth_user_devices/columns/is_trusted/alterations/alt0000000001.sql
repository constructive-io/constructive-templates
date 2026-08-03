-- Revert: schemas/myapp_auth_private/tables/auth_user_devices/columns/is_trusted/alterations/alt0000000001


ALTER TABLE myapp_auth_private.auth_user_devices 
  ALTER COLUMN is_trusted DROP NOT NULL;


