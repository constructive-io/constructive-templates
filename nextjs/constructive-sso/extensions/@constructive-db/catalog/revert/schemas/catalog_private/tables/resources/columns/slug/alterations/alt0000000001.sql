-- Revert: schemas/catalog_private/tables/resources/columns/slug/alterations/alt0000000001


ALTER TABLE catalog_private.resources 
  ALTER COLUMN slug DROP NOT NULL;