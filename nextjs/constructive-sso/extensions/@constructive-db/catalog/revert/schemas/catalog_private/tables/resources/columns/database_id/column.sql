-- Revert: schemas/catalog_private/tables/resources/columns/database_id/column


ALTER TABLE catalog_private.resources 
  DROP COLUMN database_id RESTRICT;