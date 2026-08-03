-- Revert: schemas/catalog_public/tables/namespaces/columns/database_id/alterations/alt0000000001


ALTER TABLE catalog_public.namespaces 
  ALTER COLUMN database_id DROP NOT NULL;