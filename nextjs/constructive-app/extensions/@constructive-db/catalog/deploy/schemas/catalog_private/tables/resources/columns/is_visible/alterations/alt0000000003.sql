-- Deploy: schemas/catalog_private/tables/resources/columns/is_visible/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/resources/columns/is_visible/column


COMMENT ON COLUMN catalog_private.resources.is_visible IS 'Cross-scope visibility flag propagated from the scoped source row';