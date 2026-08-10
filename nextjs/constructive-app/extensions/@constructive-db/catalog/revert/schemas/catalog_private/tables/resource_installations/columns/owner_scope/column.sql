-- Revert: schemas/catalog_private/tables/resource_installations/columns/owner_scope/column


ALTER TABLE catalog_private.resource_installations 
  DROP COLUMN owner_scope RESTRICT;