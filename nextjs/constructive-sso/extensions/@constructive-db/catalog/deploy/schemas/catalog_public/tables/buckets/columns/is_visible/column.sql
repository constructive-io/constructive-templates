-- Deploy: schemas/catalog_public/tables/buckets/columns/is_visible/column
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/buckets/table


ALTER TABLE catalog_public.buckets 
  ADD COLUMN is_visible boolean;