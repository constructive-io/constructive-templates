-- Revert: schemas/catalog_public/tables/apis/columns/created_at/alterations/alt0000000001


ALTER TABLE catalog_public.apis 
  ALTER COLUMN created_at DROP DEFAULT;