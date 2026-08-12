-- Deploy: schemas/catalog_private/tables/buckets/columns/owner_scope/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/buckets/table
-- requires: schemas/catalog_private/tables/buckets/columns/owner_scope/column


ALTER TABLE catalog_private.buckets 
  ALTER COLUMN owner_scope SET NOT NULL;