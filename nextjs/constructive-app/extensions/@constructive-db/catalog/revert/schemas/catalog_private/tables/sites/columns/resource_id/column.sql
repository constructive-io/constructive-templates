-- Revert: schemas/catalog_private/tables/sites/columns/resource_id/column


ALTER TABLE catalog_private.sites 
  DROP COLUMN resource_id RESTRICT;