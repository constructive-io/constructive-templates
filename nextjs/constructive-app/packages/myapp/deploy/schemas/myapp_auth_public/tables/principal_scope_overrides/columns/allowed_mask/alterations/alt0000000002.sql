-- Deploy: schemas/myapp_auth_public/tables/principal_scope_overrides/columns/allowed_mask/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principal_scope_overrides/columns/allowed_mask/column


COMMENT ON COLUMN myapp_auth_public.principal_scope_overrides.allowed_mask IS E'@has_guard
Optional capability mask; AND-masked with parent capabilities during cascade. NULL means no extra mask.';

