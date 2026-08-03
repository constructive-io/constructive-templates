-- Revert: schemas/catalog_public/tables/resource_installations/columns/slug/alterations/alt0000000001


ALTER TABLE catalog_public.resource_installations 
  ALTER COLUMN slug DROP NOT NULL;