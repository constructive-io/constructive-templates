-- Revert: schemas/catalog_public/tables/sites/columns/name/alterations/alt0000000001


ALTER TABLE catalog_public.sites 
  ALTER COLUMN name DROP NOT NULL;