-- Revert: schemas/catalog_public/tables/resource_installations/columns/created_at/column


ALTER TABLE catalog_public.resource_installations 
  DROP COLUMN created_at RESTRICT;