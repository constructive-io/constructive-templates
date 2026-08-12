-- Deploy: schemas/catalog_private/tables/bindings/columns/id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/bindings/table
-- requires: schemas/catalog_private/tables/bindings/columns/id/column


ALTER TABLE catalog_private.bindings 
  ALTER COLUMN id SET DEFAULT uuidv7();