-- Revert: schemas/catalog_private/tables/resource_installations/columns/slug/column


ALTER TABLE catalog_private.resource_installations 
  DROP COLUMN slug RESTRICT;