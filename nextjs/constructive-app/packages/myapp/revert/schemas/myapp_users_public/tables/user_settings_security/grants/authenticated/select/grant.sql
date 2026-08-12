-- Revert: schemas/myapp_users_public/tables/user_settings_security/grants/authenticated/select/grant


REVOKE SELECT ON myapp_users_public.user_settings_security FROM authenticated;


