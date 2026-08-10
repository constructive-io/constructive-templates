-- Revert: schemas/catalog_private/tables/resource_definitions/columns/owner_key/column


ALTER TABLE catalog_private.resource_definitions 
  DROP COLUMN owner_key RESTRICT;