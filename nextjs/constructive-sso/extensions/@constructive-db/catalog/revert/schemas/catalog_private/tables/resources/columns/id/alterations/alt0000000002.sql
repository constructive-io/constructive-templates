-- Revert: schemas/catalog_private/tables/resources/columns/id/alterations/alt0000000002


ALTER TABLE catalog_private.resources 
  ALTER COLUMN id DROP DEFAULT;