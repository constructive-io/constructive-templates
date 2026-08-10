-- Deploy: schemas/catalog_private/tables/buckets/columns/physical_name/column
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/buckets/table


ALTER TABLE catalog_private.buckets 
  ADD COLUMN physical_name text;