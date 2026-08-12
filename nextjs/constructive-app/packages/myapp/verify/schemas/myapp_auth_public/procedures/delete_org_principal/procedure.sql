-- Verify: schemas/myapp_auth_public/procedures/delete_org_principal/procedure


SELECT assert_function('myapp_auth_public.delete_org_principal(uuid)'::regprocedure, 'boolean'::regtype, false, true, 'VOLATILE');


