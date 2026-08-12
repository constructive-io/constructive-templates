-- Revert: schemas/catalog_public/tables/resource_installations/columns/created_at/alterations/alt0000000001


ALTER TABLE catalog_public.resource_installations 
  ALTER COLUMN created_at DROP DEFAULT;