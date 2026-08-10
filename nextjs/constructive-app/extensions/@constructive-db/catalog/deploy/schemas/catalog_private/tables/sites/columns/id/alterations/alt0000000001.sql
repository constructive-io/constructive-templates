-- Deploy: schemas/catalog_private/tables/sites/columns/id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites/table
-- requires: schemas/catalog_private/tables/sites/columns/id/column


ALTER TABLE catalog_private.sites 
  ALTER COLUMN id SET NOT NULL;