-- Revert: schemas/catalog_private/tables/resource_definitions/columns/updated_at/column


ALTER TABLE catalog_private.resource_definitions 
  DROP COLUMN updated_at RESTRICT;