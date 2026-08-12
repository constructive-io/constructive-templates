-- Deploy: schemas/catalog_private/tables/buckets/columns/id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/buckets/table
-- requires: schemas/catalog_private/tables/buckets/columns/id/column


ALTER TABLE catalog_private.buckets 
  ALTER COLUMN id SET DEFAULT uuidv7();