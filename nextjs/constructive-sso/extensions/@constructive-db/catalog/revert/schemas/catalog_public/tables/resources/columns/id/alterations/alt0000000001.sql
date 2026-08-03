-- Revert: schemas/catalog_public/tables/resources/columns/id/alterations/alt0000000001


ALTER TABLE catalog_public.resources 
  ALTER COLUMN id DROP NOT NULL;