-- Revert: schemas/catalog_public/tables/resources/columns/owner_scope/alterations/alt0000000001


ALTER TABLE catalog_public.resources 
  ALTER COLUMN owner_scope DROP NOT NULL;