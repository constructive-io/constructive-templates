-- Deploy: schemas/myapp_auth_private/tables/auth_user_devices/policies/enable_row_level_security
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/auth_user_devices/table


ALTER TABLE myapp_auth_private.auth_user_devices 
  ENABLE ROW LEVEL SECURITY;

