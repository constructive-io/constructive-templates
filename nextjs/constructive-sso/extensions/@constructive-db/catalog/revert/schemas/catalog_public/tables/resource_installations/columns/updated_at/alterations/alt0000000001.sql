-- Revert: schemas/catalog_public/tables/resource_installations/columns/updated_at/alterations/alt0000000001


ALTER TABLE catalog_public.resource_installations 
  ALTER COLUMN updated_at DROP DEFAULT;