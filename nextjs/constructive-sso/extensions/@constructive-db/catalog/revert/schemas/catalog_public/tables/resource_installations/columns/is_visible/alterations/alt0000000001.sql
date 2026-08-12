-- Revert: schemas/catalog_public/tables/resource_installations/columns/is_visible/alterations/alt0000000001


ALTER TABLE catalog_public.resource_installations 
  ALTER COLUMN is_visible DROP NOT NULL;