-- Revert: schemas/catalog_public/tables/resource_installations/columns/database_id/column


ALTER TABLE catalog_public.resource_installations 
  DROP COLUMN database_id RESTRICT;