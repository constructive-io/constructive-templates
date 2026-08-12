-- Revert: schemas/catalog_private/tables/resource_definitions/columns/database_id/alterations/alt0000000001


ALTER TABLE catalog_private.resource_definitions 
  ALTER COLUMN database_id DROP NOT NULL;