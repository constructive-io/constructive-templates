-- Revert: schemas/catalog_private/tables/resource_definitions/columns/namespace_id/column


ALTER TABLE catalog_private.resource_definitions 
  DROP COLUMN namespace_id RESTRICT;