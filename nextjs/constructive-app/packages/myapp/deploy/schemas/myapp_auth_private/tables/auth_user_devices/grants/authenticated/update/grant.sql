-- Deploy: schemas/myapp_auth_private/tables/auth_user_devices/grants/authenticated/update/grant
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/auth_user_devices/table


GRANT UPDATE ON myapp_auth_private.auth_user_devices TO authenticated;

