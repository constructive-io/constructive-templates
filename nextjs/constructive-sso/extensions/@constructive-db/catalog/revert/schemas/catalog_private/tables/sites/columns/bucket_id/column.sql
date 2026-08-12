-- Revert: schemas/catalog_private/tables/sites/columns/bucket_id/column


ALTER TABLE catalog_private.sites 
  DROP COLUMN bucket_id RESTRICT;