-- Deploy: schemas/catalog_private/tables/domains/columns/id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/domains/table
-- requires: schemas/catalog_private/tables/domains/columns/id/column


ALTER TABLE catalog_private.domains 
  ALTER COLUMN id SET DEFAULT uuidv7();