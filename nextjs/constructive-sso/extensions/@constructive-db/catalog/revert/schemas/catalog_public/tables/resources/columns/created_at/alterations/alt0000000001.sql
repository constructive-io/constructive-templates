-- Revert: schemas/catalog_public/tables/resources/columns/created_at/alterations/alt0000000001


ALTER TABLE catalog_public.resources 
  ALTER COLUMN created_at DROP DEFAULT;