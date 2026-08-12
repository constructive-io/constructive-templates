-- Revert: schemas/catalog_private/tables/buckets/columns/key/alterations/alt0000000001


ALTER TABLE catalog_private.buckets 
  ALTER COLUMN key DROP NOT NULL;