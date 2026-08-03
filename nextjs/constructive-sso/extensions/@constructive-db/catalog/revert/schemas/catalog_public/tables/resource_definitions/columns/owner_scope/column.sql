-- Revert: schemas/catalog_public/tables/resource_definitions/columns/owner_scope/column


ALTER TABLE catalog_public.resource_definitions 
  DROP COLUMN owner_scope RESTRICT;