-- Verify: schemas/myapp_auth_private/procedures/revoke_org_credential/procedure


SELECT assert_function('myapp_auth_private.revoke_org_credential(uuid, uuid, uuid)'::regprocedure, 'void'::regtype, false, true, 'VOLATILE');


