-- Deploy: schemas/catalog_private/tables/apps/columns/id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/apps/table
-- requires: schemas/catalog_private/tables/apps/columns/id/column


ALTER TABLE catalog_private.apps 
  ALTER COLUMN id SET DEFAULT uuidv7();