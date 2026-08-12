-- Deploy: schemas/catalog_private/tables/sites/columns/description/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites/columns/description/column


COMMENT ON COLUMN catalog_private.sites.description IS 'Display description propagated from the source row';