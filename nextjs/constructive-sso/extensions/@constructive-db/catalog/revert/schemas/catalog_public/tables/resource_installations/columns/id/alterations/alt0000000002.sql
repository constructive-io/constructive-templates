-- Revert: schemas/catalog_public/tables/resource_installations/columns/id/alterations/alt0000000002


ALTER TABLE catalog_public.resource_installations 
  ALTER COLUMN id DROP DEFAULT;