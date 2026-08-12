-- Revert: schemas/catalog_private/tables/resource_definitions/columns/id/alterations/alt0000000001


ALTER TABLE catalog_private.resource_definitions 
  ALTER COLUMN id DROP NOT NULL;