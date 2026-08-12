-- Revert: schemas/catalog_public/tables/apis/columns/owner_scope/column


ALTER TABLE catalog_public.apis 
  DROP COLUMN owner_scope RESTRICT;