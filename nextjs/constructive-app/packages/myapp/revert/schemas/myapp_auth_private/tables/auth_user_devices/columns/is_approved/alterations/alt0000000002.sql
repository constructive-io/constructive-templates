-- Revert: schemas/myapp_auth_private/tables/auth_user_devices/columns/is_approved/alterations/alt0000000002


ALTER TABLE myapp_auth_private.auth_user_devices 
  ALTER COLUMN is_approved DROP DEFAULT;


