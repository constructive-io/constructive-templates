-- Revert: schemas/catalog_public/tables/resource_installations/columns/owner_scope/column


ALTER TABLE catalog_public.resource_installations 
  DROP COLUMN owner_scope RESTRICT;