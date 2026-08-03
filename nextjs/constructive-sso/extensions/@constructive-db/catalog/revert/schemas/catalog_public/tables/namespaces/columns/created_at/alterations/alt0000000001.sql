-- Revert: schemas/catalog_public/tables/namespaces/columns/created_at/alterations/alt0000000001


ALTER TABLE catalog_public.namespaces 
  ALTER COLUMN created_at DROP DEFAULT;