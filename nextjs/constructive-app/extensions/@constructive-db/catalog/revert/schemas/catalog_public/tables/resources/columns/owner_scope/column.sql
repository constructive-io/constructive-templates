-- Revert: schemas/catalog_public/tables/resources/columns/owner_scope/column


ALTER TABLE catalog_public.resources 
  DROP COLUMN owner_scope RESTRICT;