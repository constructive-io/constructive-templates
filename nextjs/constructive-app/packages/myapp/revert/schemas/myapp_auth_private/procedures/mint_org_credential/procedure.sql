-- Revert: schemas/myapp_auth_private/procedures/mint_org_credential/procedure


DROP FUNCTION myapp_auth_private.mint_org_credential ( uuid, uuid, uuid, uuid, bytea, text, text, timestamptz, text, uuid );


