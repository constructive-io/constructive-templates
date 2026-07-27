-- Deploy: schemas/myapp_auth_private/tables/auth_user_devices/indexes/auth_user_devices_device_token_hash_idx
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/auth_user_devices/table
-- requires: schemas/myapp_auth_private/tables/auth_user_devices/columns/device_token_hash/column


CREATE INDEX auth_user_devices_device_token_hash_idx ON myapp_auth_private.auth_user_devices USING BTREE ( device_token_hash );

