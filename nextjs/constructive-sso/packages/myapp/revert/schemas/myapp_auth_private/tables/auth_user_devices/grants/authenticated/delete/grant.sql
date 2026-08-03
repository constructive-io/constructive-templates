-- Revert: schemas/myapp_auth_private/tables/auth_user_devices/grants/authenticated/delete/grant


REVOKE DELETE ON myapp_auth_private.auth_user_devices FROM authenticated;


