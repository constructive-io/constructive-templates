-- Revert: schemas/catalog_private/tables/resource_definitions/columns/kind/column


ALTER TABLE catalog_private.resource_definitions 
  DROP COLUMN kind RESTRICT;