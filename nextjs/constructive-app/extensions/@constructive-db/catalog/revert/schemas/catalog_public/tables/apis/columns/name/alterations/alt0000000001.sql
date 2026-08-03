-- Revert: schemas/catalog_public/tables/apis/columns/name/alterations/alt0000000001


ALTER TABLE catalog_public.apis 
  ALTER COLUMN name DROP NOT NULL;