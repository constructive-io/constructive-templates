-- Revert: schemas/catalog_public/tables/resource_installations/columns/is_visible/column


ALTER TABLE catalog_public.resource_installations 
  DROP COLUMN is_visible RESTRICT;