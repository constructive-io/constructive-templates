-- Deploy: schemas/myapp_auth_private/tables/app_settings_device/indexes/app_settings_device_created_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/app_settings_device/table
-- requires: schemas/myapp_auth_private/tables/app_settings_device/columns/created_at/column


CREATE INDEX app_settings_device_created_at_idx ON myapp_auth_private.app_settings_device ( created_at );

