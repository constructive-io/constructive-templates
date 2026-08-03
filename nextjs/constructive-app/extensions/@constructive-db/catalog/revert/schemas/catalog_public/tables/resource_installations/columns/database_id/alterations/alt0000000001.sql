-- Revert: schemas/catalog_public/tables/resource_installations/columns/database_id/alterations/alt0000000001


ALTER TABLE catalog_public.resource_installations 
  ALTER COLUMN database_id DROP NOT NULL;