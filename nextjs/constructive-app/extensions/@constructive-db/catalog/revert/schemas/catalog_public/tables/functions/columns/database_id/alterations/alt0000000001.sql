-- Revert: schemas/catalog_public/tables/functions/columns/database_id/alterations/alt0000000001


ALTER TABLE catalog_public.functions 
  ALTER COLUMN database_id DROP NOT NULL;