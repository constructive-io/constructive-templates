-- Deploy: schemas/catalog_private/tables/apps/columns/is_visible/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/apps/columns/is_visible/column


COMMENT ON COLUMN catalog_private.apps.is_visible IS 'Cross-scope visibility flag propagated from the scoped source row';