-- Revert: schemas/myapp_auth_private/tables/auth_user_devices/columns/first_seen_at/alterations/alt0000000002


ALTER TABLE myapp_auth_private.auth_user_devices 
  ALTER COLUMN first_seen_at DROP DEFAULT;


