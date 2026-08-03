-- Deploy: schemas/myapp_auth_private/tables/auth_user_devices/columns/first_seen_at/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/auth_user_devices/table
-- requires: schemas/myapp_auth_private/tables/auth_user_devices/columns/first_seen_at/column


ALTER TABLE myapp_auth_private.auth_user_devices 
  ALTER COLUMN first_seen_at SET DEFAULT CURRENT_TIMESTAMP;

