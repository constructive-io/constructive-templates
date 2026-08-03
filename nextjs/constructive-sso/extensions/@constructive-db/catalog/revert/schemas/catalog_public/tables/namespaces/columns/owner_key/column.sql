-- Revert: schemas/catalog_public/tables/namespaces/columns/owner_key/column


ALTER TABLE catalog_public.namespaces 
  DROP COLUMN owner_key RESTRICT;