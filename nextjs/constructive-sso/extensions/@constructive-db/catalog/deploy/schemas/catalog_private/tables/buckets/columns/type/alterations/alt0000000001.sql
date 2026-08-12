-- Deploy: schemas/catalog_private/tables/buckets/columns/type/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/buckets/table
-- requires: schemas/catalog_private/tables/buckets/columns/type/column


ALTER TABLE catalog_private.buckets 
  ALTER COLUMN type SET NOT NULL;