-- Deploy: schemas/myapp_auth_private/tables/auth_user_devices/columns/trusted_at/column
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/auth_user_devices/table


ALTER TABLE myapp_auth_private.auth_user_devices 
  ADD COLUMN trusted_at timestamptz;

