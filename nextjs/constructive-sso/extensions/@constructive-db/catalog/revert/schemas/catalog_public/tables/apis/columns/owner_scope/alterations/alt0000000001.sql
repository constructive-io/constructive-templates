-- Revert: schemas/catalog_public/tables/apis/columns/owner_scope/alterations/alt0000000001


ALTER TABLE catalog_public.apis 
  ALTER COLUMN owner_scope DROP NOT NULL;