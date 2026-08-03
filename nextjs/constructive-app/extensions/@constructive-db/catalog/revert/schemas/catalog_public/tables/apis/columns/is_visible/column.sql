-- Revert: schemas/catalog_public/tables/apis/columns/is_visible/column


ALTER TABLE catalog_public.apis 
  DROP COLUMN is_visible RESTRICT;