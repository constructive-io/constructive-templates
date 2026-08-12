-- Verify: schemas/myapp_auth_public/procedures/revoke_api_key/procedure


SELECT assert_function('myapp_auth_public.revoke_api_key(uuid)'::regprocedure, 'boolean'::regtype, false, true, 'VOLATILE');


