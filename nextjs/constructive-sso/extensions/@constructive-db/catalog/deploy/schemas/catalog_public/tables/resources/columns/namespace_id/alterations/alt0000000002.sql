-- Deploy: schemas/catalog_public/tables/resources/columns/namespace_id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/resources/columns/namespace_id/column


COMMENT ON COLUMN catalog_public.resources.namespace_id IS 'Namespace the resource lives in (source namespace row id)';