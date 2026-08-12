-- Revert: schemas/catalog_private/tables/resource_installations/columns/is_visible/column


ALTER TABLE catalog_private.resource_installations 
  DROP COLUMN is_visible RESTRICT;