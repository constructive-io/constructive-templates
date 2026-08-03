-- Revert: schemas/catalog_public/tables/resource_installations/columns/owner_key/column


ALTER TABLE catalog_public.resource_installations 
  DROP COLUMN owner_key RESTRICT;