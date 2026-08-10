-- Deploy: schemas/catalog_private/tables/functions/columns/id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/functions/table
-- requires: schemas/catalog_private/tables/functions/columns/id/column


ALTER TABLE catalog_private.functions 
  ALTER COLUMN id SET DEFAULT uuidv7();