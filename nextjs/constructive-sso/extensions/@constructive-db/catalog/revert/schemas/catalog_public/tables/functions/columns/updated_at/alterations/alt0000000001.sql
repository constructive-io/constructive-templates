-- Revert: schemas/catalog_public/tables/functions/columns/updated_at/alterations/alt0000000001


ALTER TABLE catalog_public.functions 
  ALTER COLUMN updated_at DROP DEFAULT;