-- Verify: schemas/myapp_auth_public/procedures/revoke_org_api_key/procedure


SELECT assert_function('myapp_auth_public.revoke_org_api_key(uuid, uuid)'::regprocedure, 'boolean'::regtype, false, false, 'VOLATILE');


