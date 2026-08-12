-- Revert: schemas/catalog_private/tables/apis/columns/database_id/column


ALTER TABLE catalog_private.apis 
  DROP COLUMN database_id RESTRICT;