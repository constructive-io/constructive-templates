-- Revert: schemas/catalog_public/tables/apps/columns/id/alterations/alt0000000001


ALTER TABLE catalog_public.apps 
  ALTER COLUMN id DROP NOT NULL;