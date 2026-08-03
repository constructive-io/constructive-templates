-- Revert: schemas/catalog_public/tables/apps/columns/owner_key/column


ALTER TABLE catalog_public.apps 
  DROP COLUMN owner_key RESTRICT;