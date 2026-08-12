-- Deploy: schemas/routing_public/tables/rls_settings/columns/authenticate_schema_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/rls_settings/columns/authenticate_schema_id/column


COMMENT ON COLUMN routing_public.rls_settings.authenticate_schema_id IS 'Schema containing authenticate/authenticate_strict functions (FK to metaschema_public.schema)';