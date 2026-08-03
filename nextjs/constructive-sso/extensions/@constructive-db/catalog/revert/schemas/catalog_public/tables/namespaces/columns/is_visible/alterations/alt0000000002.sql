-- Revert: schemas/catalog_public/tables/namespaces/columns/is_visible/alterations/alt0000000002


ALTER TABLE catalog_public.namespaces 
  ALTER COLUMN is_visible DROP DEFAULT;