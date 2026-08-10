-- Revert: schemas/catalog_private/tables/resources/columns/kind/column


ALTER TABLE catalog_private.resources 
  DROP COLUMN kind RESTRICT;