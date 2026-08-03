-- Revert: schemas/catalog_public/tables/apis/columns/updated_at/alterations/alt0000000001


ALTER TABLE catalog_public.apis 
  ALTER COLUMN updated_at DROP DEFAULT;