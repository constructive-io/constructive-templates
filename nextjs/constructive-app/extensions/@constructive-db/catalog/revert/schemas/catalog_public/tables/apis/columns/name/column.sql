-- Revert: schemas/catalog_public/tables/apis/columns/name/column


ALTER TABLE catalog_public.apis 
  DROP COLUMN name RESTRICT;