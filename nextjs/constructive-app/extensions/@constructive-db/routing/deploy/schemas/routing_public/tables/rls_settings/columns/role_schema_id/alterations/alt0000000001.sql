-- Deploy: schemas/routing_public/tables/rls_settings/columns/role_schema_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/rls_settings/columns/role_schema_id/column


COMMENT ON COLUMN routing_public.rls_settings.role_schema_id IS 'Schema containing current_role and related functions (FK to metaschema_public.schema)';