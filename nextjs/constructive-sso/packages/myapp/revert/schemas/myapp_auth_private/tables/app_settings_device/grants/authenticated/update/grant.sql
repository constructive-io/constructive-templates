-- Revert: schemas/myapp_auth_private/tables/app_settings_device/grants/authenticated/update/grant


REVOKE UPDATE ON myapp_auth_private.app_settings_device FROM authenticated;


