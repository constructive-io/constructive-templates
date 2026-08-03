-- Revert: schemas/catalog_public/tables/apis/columns/database_id/alterations/alt0000000001


ALTER TABLE catalog_public.apis 
  ALTER COLUMN database_id DROP NOT NULL;