-- Verify: schemas/myapp_auth_private/procedures/mint_org_credential/procedure


SELECT assert_function('myapp_auth_private.mint_org_credential(uuid, uuid, uuid, uuid, bytea, text, text, timestamptz, text, uuid)'::regprocedure, 'void'::regtype, false, true, 'VOLATILE');


