-- Revert: schemas/myapp_auth_private/tables/auth_user_devices/columns/is_approved/column


ALTER TABLE myapp_auth_private.auth_user_devices 
  DROP COLUMN is_approved RESTRICT;


