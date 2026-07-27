-- Revert: schemas/myapp_auth_public/tables/principal_entities/grants/authenticated/select/grant


REVOKE SELECT ON myapp_auth_public.principal_entities FROM authenticated;


