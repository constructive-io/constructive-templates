-- Revert: schemas/catalog_private/tables/resource_definitions/columns/id/column


ALTER TABLE catalog_private.resource_definitions 
  DROP COLUMN id RESTRICT;