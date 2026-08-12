-- Deploy: schemas/catalog_private/tables/buckets/columns/is_visible/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/buckets/table
-- requires: schemas/catalog_private/tables/buckets/columns/is_visible/column


ALTER TABLE catalog_private.buckets 
  ALTER COLUMN is_visible SET DEFAULT false;