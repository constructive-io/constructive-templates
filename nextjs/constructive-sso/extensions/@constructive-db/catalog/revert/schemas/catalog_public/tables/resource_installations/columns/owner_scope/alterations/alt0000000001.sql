-- Revert: schemas/catalog_public/tables/resource_installations/columns/owner_scope/alterations/alt0000000001


ALTER TABLE catalog_public.resource_installations 
  ALTER COLUMN owner_scope DROP NOT NULL;