-- Revert: schemas/myapp_auth_public/procedures/create_org_principal/procedure


DROP FUNCTION myapp_auth_public.create_org_principal ( text, uuid, boolean, boolean, boolean );


