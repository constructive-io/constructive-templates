-- Deploy: schemas/catalog_private/tables/namespaces/columns/id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/namespaces/table
-- requires: schemas/catalog_private/tables/namespaces/columns/id/column


ALTER TABLE catalog_private.namespaces 
  ALTER COLUMN id SET DEFAULT uuidv7();