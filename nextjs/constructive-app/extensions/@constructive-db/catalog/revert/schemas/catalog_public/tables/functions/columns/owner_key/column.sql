-- Revert: schemas/catalog_public/tables/functions/columns/owner_key/column


ALTER TABLE catalog_public.functions 
  DROP COLUMN owner_key RESTRICT;