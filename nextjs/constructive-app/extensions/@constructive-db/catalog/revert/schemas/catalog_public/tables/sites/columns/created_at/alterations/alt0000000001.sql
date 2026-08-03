-- Revert: schemas/catalog_public/tables/sites/columns/created_at/alterations/alt0000000001


ALTER TABLE catalog_public.sites 
  ALTER COLUMN created_at DROP DEFAULT;