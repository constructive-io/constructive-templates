-- Revert: schemas/catalog_private/tables/buckets/columns/type/alterations/alt0000000001


ALTER TABLE catalog_private.buckets 
  ALTER COLUMN type DROP NOT NULL;