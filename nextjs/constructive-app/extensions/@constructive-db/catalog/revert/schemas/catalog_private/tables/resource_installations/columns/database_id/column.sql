-- Revert: schemas/catalog_private/tables/resource_installations/columns/database_id/column


ALTER TABLE catalog_private.resource_installations 
  DROP COLUMN database_id RESTRICT;