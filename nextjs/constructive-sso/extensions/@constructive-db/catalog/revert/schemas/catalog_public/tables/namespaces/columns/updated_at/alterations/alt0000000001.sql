-- Revert: schemas/catalog_public/tables/namespaces/columns/updated_at/alterations/alt0000000001


ALTER TABLE catalog_public.namespaces 
  ALTER COLUMN updated_at DROP DEFAULT;