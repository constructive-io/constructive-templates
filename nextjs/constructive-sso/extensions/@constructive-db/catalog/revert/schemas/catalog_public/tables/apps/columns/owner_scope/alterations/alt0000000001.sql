-- Revert: schemas/catalog_public/tables/apps/columns/owner_scope/alterations/alt0000000001


ALTER TABLE catalog_public.apps 
  ALTER COLUMN owner_scope DROP NOT NULL;