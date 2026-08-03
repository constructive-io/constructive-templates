-- Revert: schemas/catalog_public/tables/functions/columns/owner_scope/column


ALTER TABLE catalog_public.functions 
  DROP COLUMN owner_scope RESTRICT;