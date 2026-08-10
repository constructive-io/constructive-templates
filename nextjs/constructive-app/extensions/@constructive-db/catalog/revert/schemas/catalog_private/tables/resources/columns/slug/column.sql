-- Revert: schemas/catalog_private/tables/resources/columns/slug/column


ALTER TABLE catalog_private.resources 
  DROP COLUMN slug RESTRICT;