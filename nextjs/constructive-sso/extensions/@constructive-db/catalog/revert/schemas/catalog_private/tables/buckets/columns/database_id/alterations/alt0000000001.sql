-- Revert: schemas/catalog_private/tables/buckets/columns/database_id/alterations/alt0000000001


ALTER TABLE catalog_private.buckets 
  ALTER COLUMN database_id DROP NOT NULL;