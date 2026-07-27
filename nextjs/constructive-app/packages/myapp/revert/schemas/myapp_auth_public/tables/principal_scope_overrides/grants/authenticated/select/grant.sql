-- Revert: schemas/myapp_auth_public/tables/principal_scope_overrides/grants/authenticated/select/grant


REVOKE SELECT ON myapp_auth_public.principal_scope_overrides FROM authenticated;


