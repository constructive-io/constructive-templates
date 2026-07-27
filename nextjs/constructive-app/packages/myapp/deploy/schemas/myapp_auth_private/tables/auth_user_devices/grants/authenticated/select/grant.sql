-- Deploy: schemas/myapp_auth_private/tables/auth_user_devices/grants/authenticated/select/grant
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/auth_user_devices/table


GRANT SELECT ON myapp_auth_private.auth_user_devices TO authenticated;

