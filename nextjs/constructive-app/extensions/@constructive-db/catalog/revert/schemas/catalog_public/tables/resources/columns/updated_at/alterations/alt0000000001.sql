-- Revert: schemas/catalog_public/tables/resources/columns/updated_at/alterations/alt0000000001


ALTER TABLE catalog_public.resources 
  ALTER COLUMN updated_at DROP DEFAULT;