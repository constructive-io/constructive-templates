-- Deploy: schemas/catalog_public/tables/resource_definitions/columns/namespace_id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/resource_definitions/columns/namespace_id/column


COMMENT ON COLUMN catalog_public.resource_definitions.namespace_id IS 'Namespace the definition lives in (source namespace row id)';