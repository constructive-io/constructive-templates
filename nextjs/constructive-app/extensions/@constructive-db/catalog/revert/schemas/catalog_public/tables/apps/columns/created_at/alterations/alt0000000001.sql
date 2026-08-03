-- Revert: schemas/catalog_public/tables/apps/columns/created_at/alterations/alt0000000001


ALTER TABLE catalog_public.apps 
  ALTER COLUMN created_at DROP DEFAULT;