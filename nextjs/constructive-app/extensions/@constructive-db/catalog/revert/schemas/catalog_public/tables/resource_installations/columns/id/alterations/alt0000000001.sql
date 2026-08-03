-- Revert: schemas/catalog_public/tables/resource_installations/columns/id/alterations/alt0000000001


ALTER TABLE catalog_public.resource_installations 
  ALTER COLUMN id DROP NOT NULL;