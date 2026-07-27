-- Deploy: schemas/myapp_auth_private/tables/app_settings_device/grants/authenticated/select/grant
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/app_settings_device/table


GRANT SELECT ON myapp_auth_private.app_settings_device TO authenticated;

