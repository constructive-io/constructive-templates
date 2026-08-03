-- Revert: schemas/catalog_public/tables/sites/columns/owner_scope/alterations/alt0000000001


ALTER TABLE catalog_public.sites 
  ALTER COLUMN owner_scope DROP NOT NULL;