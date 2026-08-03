-- Revert: schemas/catalog_public/tables/resource_installations/columns/slug/column


ALTER TABLE catalog_public.resource_installations 
  DROP COLUMN slug RESTRICT;