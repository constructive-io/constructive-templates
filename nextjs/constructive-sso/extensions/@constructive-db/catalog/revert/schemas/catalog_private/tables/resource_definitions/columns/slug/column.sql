-- Revert: schemas/catalog_private/tables/resource_definitions/columns/slug/column


ALTER TABLE catalog_private.resource_definitions 
  DROP COLUMN slug RESTRICT;