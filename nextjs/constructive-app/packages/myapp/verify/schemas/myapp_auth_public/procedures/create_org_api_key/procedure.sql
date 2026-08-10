-- Verify: schemas/myapp_auth_public/procedures/create_org_api_key/procedure


SELECT assert_function('myapp_auth_public.create_org_api_key(uuid, uuid, text, text, text, interval)'::regprocedure, 'record'::regtype, false, false, 'VOLATILE');


