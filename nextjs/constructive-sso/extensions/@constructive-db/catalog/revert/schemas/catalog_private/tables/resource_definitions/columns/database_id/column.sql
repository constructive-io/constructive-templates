-- Revert: schemas/catalog_private/tables/resource_definitions/columns/database_id/column


ALTER TABLE catalog_private.resource_definitions 
  DROP COLUMN database_id RESTRICT;