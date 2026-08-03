-- Revert: schemas/catalog_public/tables/functions/columns/owner_scope/alterations/alt0000000001


ALTER TABLE catalog_public.functions 
  ALTER COLUMN owner_scope DROP NOT NULL;