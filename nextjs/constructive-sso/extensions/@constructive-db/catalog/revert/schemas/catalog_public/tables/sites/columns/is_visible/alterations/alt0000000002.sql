-- Revert: schemas/catalog_public/tables/sites/columns/is_visible/alterations/alt0000000002


ALTER TABLE catalog_public.sites 
  ALTER COLUMN is_visible DROP DEFAULT;