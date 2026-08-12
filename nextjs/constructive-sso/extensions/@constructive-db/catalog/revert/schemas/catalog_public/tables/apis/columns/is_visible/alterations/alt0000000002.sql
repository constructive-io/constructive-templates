-- Revert: schemas/catalog_public/tables/apis/columns/is_visible/alterations/alt0000000002


ALTER TABLE catalog_public.apis 
  ALTER COLUMN is_visible DROP DEFAULT;