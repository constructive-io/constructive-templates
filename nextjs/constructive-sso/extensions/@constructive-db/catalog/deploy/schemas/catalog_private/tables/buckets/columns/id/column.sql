-- Deploy: schemas/catalog_private/tables/buckets/columns/id/column
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/buckets/table


ALTER TABLE catalog_private.buckets 
  ADD COLUMN id uuid;