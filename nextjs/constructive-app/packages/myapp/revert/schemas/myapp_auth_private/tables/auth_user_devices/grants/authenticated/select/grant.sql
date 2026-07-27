-- Revert: schemas/myapp_auth_private/tables/auth_user_devices/grants/authenticated/select/grant


REVOKE SELECT ON myapp_auth_private.auth_user_devices FROM authenticated;


