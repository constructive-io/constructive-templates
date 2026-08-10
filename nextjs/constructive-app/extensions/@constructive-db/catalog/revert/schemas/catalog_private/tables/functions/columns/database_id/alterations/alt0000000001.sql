-- Revert: schemas/catalog_private/tables/functions/columns/database_id/alterations/alt0000000001


ALTER TABLE catalog_private.functions 
  ALTER COLUMN database_id DROP NOT NULL;