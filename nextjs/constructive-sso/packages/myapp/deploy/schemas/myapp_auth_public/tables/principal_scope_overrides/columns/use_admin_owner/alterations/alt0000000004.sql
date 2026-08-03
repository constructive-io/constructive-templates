-- Deploy: schemas/myapp_auth_public/tables/principal_scope_overrides/columns/use_admin_owner/alterations/alt0000000004
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principal_scope_overrides/columns/use_admin_owner/column


COMMENT ON COLUMN myapp_auth_public.principal_scope_overrides.use_admin_owner IS E'@has_guard
Whether this principal inherits admin/owner at this scope (default true = inherit from parent)';

