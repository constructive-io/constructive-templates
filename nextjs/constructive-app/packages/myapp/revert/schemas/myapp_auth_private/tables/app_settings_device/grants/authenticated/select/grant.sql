-- Revert: schemas/myapp_auth_private/tables/app_settings_device/grants/authenticated/select/grant


REVOKE SELECT ON myapp_auth_private.app_settings_device FROM authenticated;


