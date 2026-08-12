-- Revert: schemas/catalog_private/tables/resource_definitions/columns/owner_scope/alterations/alt0000000001


ALTER TABLE catalog_private.resource_definitions 
  ALTER COLUMN owner_scope DROP NOT NULL;