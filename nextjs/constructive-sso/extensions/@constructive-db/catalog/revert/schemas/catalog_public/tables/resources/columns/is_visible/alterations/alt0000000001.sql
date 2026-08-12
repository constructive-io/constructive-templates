-- Revert: schemas/catalog_public/tables/resources/columns/is_visible/alterations/alt0000000001


ALTER TABLE catalog_public.resources 
  ALTER COLUMN is_visible DROP NOT NULL;