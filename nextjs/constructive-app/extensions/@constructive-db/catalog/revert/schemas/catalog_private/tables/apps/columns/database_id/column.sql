-- Revert: schemas/catalog_private/tables/apps/columns/database_id/column


ALTER TABLE catalog_private.apps 
  DROP COLUMN database_id RESTRICT;