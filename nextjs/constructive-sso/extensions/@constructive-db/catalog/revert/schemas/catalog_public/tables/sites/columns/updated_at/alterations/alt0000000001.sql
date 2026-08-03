-- Revert: schemas/catalog_public/tables/sites/columns/updated_at/alterations/alt0000000001


ALTER TABLE catalog_public.sites 
  ALTER COLUMN updated_at DROP DEFAULT;