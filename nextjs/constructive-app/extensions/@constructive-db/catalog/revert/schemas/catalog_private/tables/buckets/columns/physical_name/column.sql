-- Revert: schemas/catalog_private/tables/buckets/columns/physical_name/column


ALTER TABLE catalog_private.buckets 
  DROP COLUMN physical_name RESTRICT;