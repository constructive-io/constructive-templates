-- Revert: schemas/catalog_private/tables/buckets/columns/is_visible/alterations/alt0000000001


ALTER TABLE catalog_private.buckets 
  ALTER COLUMN is_visible DROP NOT NULL;