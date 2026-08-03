-- Revert: schemas/catalog_public/tables/resource_installations/columns/namespace_id/column


ALTER TABLE catalog_public.resource_installations 
  DROP COLUMN namespace_id RESTRICT;