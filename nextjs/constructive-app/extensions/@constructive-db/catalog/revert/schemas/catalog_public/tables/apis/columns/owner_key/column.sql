-- Revert: schemas/catalog_public/tables/apis/columns/owner_key/column


ALTER TABLE catalog_public.apis 
  DROP COLUMN owner_key RESTRICT;