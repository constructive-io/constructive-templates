-- Revert: schemas/catalog_public/tables/domains/columns/owner_key/column


ALTER TABLE catalog_public.domains 
  DROP COLUMN owner_key RESTRICT;