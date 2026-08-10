-- Revert: schemas/catalog_private/tables/sites/columns/database_id/alterations/alt0000000001


ALTER TABLE catalog_private.sites 
  ALTER COLUMN database_id DROP NOT NULL;