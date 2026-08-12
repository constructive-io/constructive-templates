-- Revert: schemas/catalog_private/tables/apps/columns/database_id/alterations/alt0000000001


ALTER TABLE catalog_private.apps 
  ALTER COLUMN database_id DROP NOT NULL;