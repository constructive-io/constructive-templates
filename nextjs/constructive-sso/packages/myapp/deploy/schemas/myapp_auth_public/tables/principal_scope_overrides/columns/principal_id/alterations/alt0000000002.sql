-- Deploy: schemas/myapp_auth_public/tables/principal_scope_overrides/columns/principal_id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principal_scope_overrides/columns/principal_id/column


COMMENT ON COLUMN myapp_auth_public.principal_scope_overrides.principal_id IS 'The principal this override applies to';

