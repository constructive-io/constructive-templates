-- Revert: schemas/catalog_private/tables/namespaces/columns/database_id/alterations/alt0000000001


ALTER TABLE catalog_private.namespaces 
  ALTER COLUMN database_id DROP NOT NULL;