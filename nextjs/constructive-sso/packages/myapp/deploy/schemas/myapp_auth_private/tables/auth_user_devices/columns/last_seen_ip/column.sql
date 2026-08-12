-- Deploy: schemas/myapp_auth_private/tables/auth_user_devices/columns/last_seen_ip/column
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/auth_user_devices/table


ALTER TABLE myapp_auth_private.auth_user_devices 
  ADD COLUMN last_seen_ip inet;

