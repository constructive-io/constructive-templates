-- Revert: schemas/catalog_public/tables/apps/columns/name/alterations/alt0000000001


ALTER TABLE catalog_public.apps 
  ALTER COLUMN name DROP NOT NULL;