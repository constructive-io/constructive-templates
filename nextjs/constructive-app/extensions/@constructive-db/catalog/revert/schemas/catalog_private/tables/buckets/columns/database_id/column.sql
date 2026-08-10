-- Revert: schemas/catalog_private/tables/buckets/columns/database_id/column


ALTER TABLE catalog_private.buckets 
  DROP COLUMN database_id RESTRICT;