-- Revert: schemas/catalog_public/tables/functions/columns/created_at/alterations/alt0000000001


ALTER TABLE catalog_public.functions 
  ALTER COLUMN created_at DROP DEFAULT;