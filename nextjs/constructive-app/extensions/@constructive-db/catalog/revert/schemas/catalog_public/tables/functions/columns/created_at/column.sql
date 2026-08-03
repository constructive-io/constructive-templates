-- Revert: schemas/catalog_public/tables/functions/columns/created_at/column


ALTER TABLE catalog_public.functions 
  DROP COLUMN created_at RESTRICT;