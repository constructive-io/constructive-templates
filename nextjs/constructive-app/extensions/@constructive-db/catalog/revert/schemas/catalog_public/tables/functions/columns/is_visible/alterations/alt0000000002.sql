-- Revert: schemas/catalog_public/tables/functions/columns/is_visible/alterations/alt0000000002


ALTER TABLE catalog_public.functions 
  ALTER COLUMN is_visible DROP DEFAULT;