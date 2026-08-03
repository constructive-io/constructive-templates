-- Revert: schemas/catalog_public/tables/resources/columns/kind/alterations/alt0000000001


ALTER TABLE catalog_public.resources 
  ALTER COLUMN kind DROP NOT NULL;