-- Revert: schemas/catalog_public/tables/resources/columns/id/alterations/alt0000000002


ALTER TABLE catalog_public.resources 
  ALTER COLUMN id DROP DEFAULT;