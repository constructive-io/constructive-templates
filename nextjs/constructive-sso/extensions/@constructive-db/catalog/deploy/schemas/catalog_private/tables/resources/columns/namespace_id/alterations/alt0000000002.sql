-- Deploy: schemas/catalog_private/tables/resources/columns/namespace_id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/resources/columns/namespace_id/column


COMMENT ON COLUMN catalog_private.resources.namespace_id IS 'Namespace the resource lives in (source namespace row id)';