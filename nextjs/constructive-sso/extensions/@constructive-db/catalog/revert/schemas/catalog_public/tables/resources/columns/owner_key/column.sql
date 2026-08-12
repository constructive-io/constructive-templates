-- Revert: schemas/catalog_public/tables/resources/columns/owner_key/column


ALTER TABLE catalog_public.resources 
  DROP COLUMN owner_key RESTRICT;