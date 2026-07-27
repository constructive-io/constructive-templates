-- Deploy: schemas/myapp_auth_private/tables/auth_user_devices/indexes/auth_user_devices_updated_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/auth_user_devices/table
-- requires: schemas/myapp_auth_private/tables/auth_user_devices/columns/updated_at/column


CREATE INDEX auth_user_devices_updated_at_idx ON myapp_auth_private.auth_user_devices ( updated_at );

