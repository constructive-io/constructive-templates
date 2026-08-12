-- Revert: schemas/catalog_private/tables/resource_definitions/columns/created_at/column


ALTER TABLE catalog_private.resource_definitions 
  DROP COLUMN created_at RESTRICT;