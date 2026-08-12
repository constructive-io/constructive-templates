-- Revert: schemas/myapp_auth_private/tables/auth_user_devices/columns/first_seen_at/column


ALTER TABLE myapp_auth_private.auth_user_devices 
  DROP COLUMN first_seen_at RESTRICT;


