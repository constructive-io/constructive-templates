-- Revert: schemas/catalog_public/tables/resource_installations/columns/updated_at/column


ALTER TABLE catalog_public.resource_installations 
  DROP COLUMN updated_at RESTRICT;