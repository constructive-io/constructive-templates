-- Verify: schemas/myapp_auth_private/procedures/auth_settings/procedure


SELECT assert_function('myapp_auth_private.auth_settings()'::regprocedure, 'myapp_auth_private.app_settings_auth'::regtype, false, true, 'STABLE');


