-- Revert: schemas/catalog_public/tables/apps/columns/database_id/alterations/alt0000000001


ALTER TABLE catalog_public.apps 
  ALTER COLUMN database_id DROP NOT NULL;