-- Deploy: schemas/catalog_public/tables/buckets/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/buckets/table


ALTER TABLE catalog_public.buckets 
  DISABLE ROW LEVEL SECURITY;