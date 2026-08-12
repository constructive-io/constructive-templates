-- Revert: schemas/catalog_private/tables/functions/columns/database_id/column


ALTER TABLE catalog_private.functions 
  DROP COLUMN database_id RESTRICT;