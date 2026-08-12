-- Deploy: schemas/routing_public/tables/rls_settings/columns/current_ip_address_function_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/rls_settings/columns/current_ip_address_function_id/column


COMMENT ON COLUMN routing_public.rls_settings.current_ip_address_function_id IS 'Reference to the current_ip_address function (FK to metaschema_public.function)';