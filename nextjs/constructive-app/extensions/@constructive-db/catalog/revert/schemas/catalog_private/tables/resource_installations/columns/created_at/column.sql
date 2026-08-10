-- Revert: schemas/catalog_private/tables/resource_installations/columns/created_at/column


ALTER TABLE catalog_private.resource_installations 
  DROP COLUMN created_at RESTRICT;