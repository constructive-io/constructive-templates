-- Revert: schemas/catalog_public/tables/sites/columns/owner_key/column


ALTER TABLE catalog_public.sites 
  DROP COLUMN owner_key RESTRICT;