-- Deploy: schemas/myapp_auth_public/tables/principal_scope_overrides/columns/is_read_only/alterations/alt0000000004
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principal_scope_overrides/columns/is_read_only/column


COMMENT ON COLUMN myapp_auth_public.principal_scope_overrides.is_read_only IS E'@has_guard
Whether this principal is restricted to read-only at this scope';

