-- Verify: schemas/myapp_auth_private/procedures/rotate_identity_provider_app_secret/procedure


SELECT assert_function('myapp_auth_private.rotate_identity_provider_app_secret(uuid, text)'::regprocedure, 'boolean'::regtype, false, true, 'VOLATILE');


