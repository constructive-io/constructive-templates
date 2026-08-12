-- Verify: schemas/myapp_auth_public/procedures/get_mfa_status/procedure


SELECT assert_function('myapp_auth_public.get_mfa_status()'::regprocedure, 'record'::regtype, false, true, 'STABLE');


