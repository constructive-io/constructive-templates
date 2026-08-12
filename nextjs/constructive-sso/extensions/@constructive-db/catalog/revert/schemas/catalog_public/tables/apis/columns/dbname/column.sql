-- Revert: schemas/catalog_public/tables/apis/columns/dbname/column


ALTER TABLE catalog_public.apis 
  DROP COLUMN dbname RESTRICT;