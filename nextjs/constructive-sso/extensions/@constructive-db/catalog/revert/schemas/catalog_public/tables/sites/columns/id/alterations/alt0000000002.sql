-- Revert: schemas/catalog_public/tables/sites/columns/id/alterations/alt0000000002


ALTER TABLE catalog_public.sites 
  ALTER COLUMN id DROP DEFAULT;