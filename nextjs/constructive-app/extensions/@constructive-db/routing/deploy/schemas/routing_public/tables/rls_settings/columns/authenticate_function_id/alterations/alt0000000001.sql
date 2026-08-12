-- Deploy: schemas/routing_public/tables/rls_settings/columns/authenticate_function_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/rls_settings/columns/authenticate_function_id/column


COMMENT ON COLUMN routing_public.rls_settings.authenticate_function_id IS 'Reference to the authenticate function (FK to metaschema_public.function)';