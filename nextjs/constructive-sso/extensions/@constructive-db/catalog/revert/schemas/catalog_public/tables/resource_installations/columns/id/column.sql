-- Revert: schemas/catalog_public/tables/resource_installations/columns/id/column


ALTER TABLE catalog_public.resource_installations 
  DROP COLUMN id RESTRICT;