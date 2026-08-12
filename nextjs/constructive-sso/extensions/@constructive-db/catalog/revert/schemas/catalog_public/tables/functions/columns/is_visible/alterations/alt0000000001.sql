-- Revert: schemas/catalog_public/tables/functions/columns/is_visible/alterations/alt0000000001


ALTER TABLE catalog_public.functions 
  ALTER COLUMN is_visible DROP NOT NULL;