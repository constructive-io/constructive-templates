-- Revert: schemas/catalog_private/tables/resource_definitions/columns/is_visible/column


ALTER TABLE catalog_private.resource_definitions 
  DROP COLUMN is_visible RESTRICT;