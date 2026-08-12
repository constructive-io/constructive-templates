-- Revert: schemas/catalog_private/tables/resource_definitions/columns/slug/alterations/alt0000000001


ALTER TABLE catalog_private.resource_definitions 
  ALTER COLUMN slug DROP NOT NULL;