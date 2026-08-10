-- Revert: schemas/catalog_private/tables/resources/columns/id/column


ALTER TABLE catalog_private.resources 
  DROP COLUMN id RESTRICT;