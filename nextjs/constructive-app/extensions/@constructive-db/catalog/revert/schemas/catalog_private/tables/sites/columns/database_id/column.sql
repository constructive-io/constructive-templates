-- Revert: schemas/catalog_private/tables/sites/columns/database_id/column


ALTER TABLE catalog_private.sites 
  DROP COLUMN database_id RESTRICT;