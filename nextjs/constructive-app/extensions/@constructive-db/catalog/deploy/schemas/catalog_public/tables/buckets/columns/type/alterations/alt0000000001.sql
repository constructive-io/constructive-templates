-- Deploy: schemas/catalog_public/tables/buckets/columns/type/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/buckets/table
-- requires: schemas/catalog_public/tables/buckets/columns/type/column


ALTER TABLE catalog_public.buckets 
  ALTER COLUMN type SET NOT NULL;