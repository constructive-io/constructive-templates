-- Revert: schemas/catalog_public/tables/apps/columns/updated_at/alterations/alt0000000001


ALTER TABLE catalog_public.apps 
  ALTER COLUMN updated_at DROP DEFAULT;