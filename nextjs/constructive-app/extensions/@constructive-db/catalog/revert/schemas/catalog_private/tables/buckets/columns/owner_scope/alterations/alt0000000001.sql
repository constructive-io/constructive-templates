-- Revert: schemas/catalog_private/tables/buckets/columns/owner_scope/alterations/alt0000000001


ALTER TABLE catalog_private.buckets 
  ALTER COLUMN owner_scope DROP NOT NULL;