-- Deploy: schemas/myapp_auth_private/tables/auth_user_devices/columns/last_seen_at/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/auth_user_devices/table
-- requires: schemas/myapp_auth_private/tables/auth_user_devices/columns/last_seen_at/column


ALTER TABLE myapp_auth_private.auth_user_devices 
  ALTER COLUMN last_seen_at SET NOT NULL;

