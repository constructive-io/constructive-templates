-- Deploy: schemas/myapp_auth_public/tables/principal_scope_overrides/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principal_scope_overrides/table


COMMENT ON TABLE myapp_auth_public.principal_scope_overrides IS E'@behavior -insert -update -delete
@has_guard
Per-scope permission overrides for principals. No row = full access; row exists = apply restrictions.';

