-- Deploy: schemas/myapp_auth_public/tables/principal_scope_overrides/columns/membership_type/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principal_scope_overrides/columns/membership_type/column


COMMENT ON COLUMN myapp_auth_public.principal_scope_overrides.membership_type IS E'The scope level (membership_type) this override restricts';

