-- Deploy: schemas/myapp_auth_public/tables/principal_scope_overrides/columns/allowed_mask/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principal_scope_overrides/columns/allowed_mask/column


COMMENT ON COLUMN myapp_auth_public.principal_scope_overrides.allowed_mask IS E'Optional permission mask; AND-masked with parent permissions during cascade. NULL means no extra mask.';

