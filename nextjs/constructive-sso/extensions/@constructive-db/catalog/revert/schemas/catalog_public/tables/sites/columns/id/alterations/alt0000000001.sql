-- Revert: schemas/catalog_public/tables/sites/columns/id/alterations/alt0000000001


ALTER TABLE catalog_public.sites 
  ALTER COLUMN id DROP NOT NULL;