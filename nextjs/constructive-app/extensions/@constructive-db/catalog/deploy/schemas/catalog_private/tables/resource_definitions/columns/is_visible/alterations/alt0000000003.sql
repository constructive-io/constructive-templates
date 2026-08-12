-- Deploy: schemas/catalog_private/tables/resource_definitions/columns/is_visible/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/resource_definitions/columns/is_visible/column


COMMENT ON COLUMN catalog_private.resource_definitions.is_visible IS 'Cross-scope visibility flag propagated from the scoped source row';