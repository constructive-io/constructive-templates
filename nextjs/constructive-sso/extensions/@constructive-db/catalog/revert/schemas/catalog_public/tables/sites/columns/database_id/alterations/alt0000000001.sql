-- Revert: schemas/catalog_public/tables/sites/columns/database_id/alterations/alt0000000001


ALTER TABLE catalog_public.sites 
  ALTER COLUMN database_id DROP NOT NULL;