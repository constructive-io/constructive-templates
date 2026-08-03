-- Revert: schemas/catalog_public/tables/resources/columns/slug/alterations/alt0000000001


ALTER TABLE catalog_public.resources 
  ALTER COLUMN slug DROP NOT NULL;