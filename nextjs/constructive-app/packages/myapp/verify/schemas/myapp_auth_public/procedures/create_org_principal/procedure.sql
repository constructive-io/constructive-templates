-- Verify: schemas/myapp_auth_public/procedures/create_org_principal/procedure


SELECT assert_function('myapp_auth_public.create_org_principal(text, uuid, boolean, boolean, boolean)'::regprocedure, 'uuid'::regtype, false, true, 'VOLATILE');


