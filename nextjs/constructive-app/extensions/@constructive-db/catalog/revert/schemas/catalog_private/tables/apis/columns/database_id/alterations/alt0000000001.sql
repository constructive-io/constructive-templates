-- Revert: schemas/catalog_private/tables/apis/columns/database_id/alterations/alt0000000001


ALTER TABLE catalog_private.apis 
  ALTER COLUMN database_id DROP NOT NULL;