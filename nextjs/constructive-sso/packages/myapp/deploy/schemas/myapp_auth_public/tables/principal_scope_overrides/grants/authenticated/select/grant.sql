-- Deploy: schemas/myapp_auth_public/tables/principal_scope_overrides/grants/authenticated/select/grant
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principal_scope_overrides/table


GRANT SELECT ON myapp_auth_public.principal_scope_overrides TO authenticated;

