-- Revert: schemas/catalog_private/tables/buckets/columns/is_visible/column


ALTER TABLE catalog_private.buckets 
  DROP COLUMN is_visible RESTRICT;