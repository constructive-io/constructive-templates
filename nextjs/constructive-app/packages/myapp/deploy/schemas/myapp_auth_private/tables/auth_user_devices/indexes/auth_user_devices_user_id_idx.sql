-- Deploy: schemas/myapp_auth_private/tables/auth_user_devices/indexes/auth_user_devices_user_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/auth_user_devices/table
-- requires: schemas/myapp_auth_private/tables/auth_user_devices/columns/user_id/column


CREATE INDEX auth_user_devices_user_id_idx ON myapp_auth_private.auth_user_devices USING BTREE ( user_id );

