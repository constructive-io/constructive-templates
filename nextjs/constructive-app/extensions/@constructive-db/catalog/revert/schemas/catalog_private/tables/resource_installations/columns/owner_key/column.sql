-- Revert: schemas/catalog_private/tables/resource_installations/columns/owner_key/column


ALTER TABLE catalog_private.resource_installations 
  DROP COLUMN owner_key RESTRICT;