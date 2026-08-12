-- Revert: schemas/catalog_private/tables/resources/columns/database_id/alterations/alt0000000001


ALTER TABLE catalog_private.resources 
  ALTER COLUMN database_id DROP NOT NULL;