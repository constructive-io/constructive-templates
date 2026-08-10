-- Deploy: schemas/catalog_private/tables/sites/columns/name/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites/table
-- requires: schemas/catalog_private/tables/sites/columns/name/column


ALTER TABLE catalog_private.sites 
  ALTER COLUMN name SET NOT NULL;