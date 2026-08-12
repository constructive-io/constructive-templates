-- Revert: schemas/catalog_private/tables/resource_installations/columns/updated_at/column


ALTER TABLE catalog_private.resource_installations 
  DROP COLUMN updated_at RESTRICT;