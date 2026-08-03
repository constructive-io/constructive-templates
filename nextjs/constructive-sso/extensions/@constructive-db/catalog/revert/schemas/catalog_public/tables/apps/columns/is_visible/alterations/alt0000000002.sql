-- Revert: schemas/catalog_public/tables/apps/columns/is_visible/alterations/alt0000000002


ALTER TABLE catalog_public.apps 
  ALTER COLUMN is_visible DROP DEFAULT;