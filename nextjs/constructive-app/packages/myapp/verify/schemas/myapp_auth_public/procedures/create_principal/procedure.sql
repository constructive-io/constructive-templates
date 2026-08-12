-- Verify: schemas/myapp_auth_public/procedures/create_principal/procedure


SELECT assert_function('myapp_auth_public.create_principal(text, boolean, uuid[], boolean, boolean)'::regprocedure, 'uuid'::regtype, false, true, 'VOLATILE');


