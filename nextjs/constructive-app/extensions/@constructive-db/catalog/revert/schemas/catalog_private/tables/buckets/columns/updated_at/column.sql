-- Revert: schemas/catalog_private/tables/buckets/columns/updated_at/column


ALTER TABLE catalog_private.buckets 
  DROP COLUMN updated_at RESTRICT;