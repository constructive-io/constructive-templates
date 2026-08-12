-- Deploy: schemas/myapp_auth_public/tables/principal_scope_overrides/columns/is_active/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principal_scope_overrides/columns/is_active/column


COMMENT ON COLUMN myapp_auth_public.principal_scope_overrides.is_active IS E'Whether this scope is active for this principal; false disables all access at this scope';

