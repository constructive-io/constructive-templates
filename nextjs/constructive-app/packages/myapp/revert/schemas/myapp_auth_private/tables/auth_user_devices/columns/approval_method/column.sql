-- Revert: schemas/myapp_auth_private/tables/auth_user_devices/columns/approval_method/column


ALTER TABLE myapp_auth_private.auth_user_devices 
  DROP COLUMN approval_method RESTRICT;


