-- Deploy: schemas/catalog_private/tables/bindings/columns/bucket_id/column
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/bindings/table


ALTER TABLE catalog_private.bindings 
  ADD COLUMN bucket_id uuid;