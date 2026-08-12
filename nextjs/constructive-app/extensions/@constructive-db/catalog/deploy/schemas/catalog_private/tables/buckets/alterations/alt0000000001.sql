-- Deploy: schemas/catalog_private/tables/buckets/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/buckets/table


ALTER TABLE catalog_private.buckets 
  DISABLE ROW LEVEL SECURITY;