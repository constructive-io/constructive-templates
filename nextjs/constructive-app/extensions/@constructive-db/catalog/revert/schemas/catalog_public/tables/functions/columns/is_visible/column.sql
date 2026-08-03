-- Revert: schemas/catalog_public/tables/functions/columns/is_visible/column


ALTER TABLE catalog_public.functions 
  DROP COLUMN is_visible RESTRICT;