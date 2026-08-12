-- Revert: schemas/catalog_private/tables/resource_installations/columns/id/column


ALTER TABLE catalog_private.resource_installations 
  DROP COLUMN id RESTRICT;