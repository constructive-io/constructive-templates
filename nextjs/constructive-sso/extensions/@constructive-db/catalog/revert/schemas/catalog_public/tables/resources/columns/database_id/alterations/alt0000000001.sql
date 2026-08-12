-- Revert: schemas/catalog_public/tables/resources/columns/database_id/alterations/alt0000000001


ALTER TABLE catalog_public.resources 
  ALTER COLUMN database_id DROP NOT NULL;