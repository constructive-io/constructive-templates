-- Revert: schemas/myapp_auth_private/tables/auth_user_devices/columns/trust_expires_at/column


ALTER TABLE myapp_auth_private.auth_user_devices 
  DROP COLUMN trust_expires_at RESTRICT;


