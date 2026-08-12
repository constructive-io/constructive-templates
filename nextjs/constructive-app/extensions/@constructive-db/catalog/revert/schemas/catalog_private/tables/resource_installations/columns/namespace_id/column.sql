-- Revert: schemas/catalog_private/tables/resource_installations/columns/namespace_id/column


ALTER TABLE catalog_private.resource_installations 
  DROP COLUMN namespace_id RESTRICT;