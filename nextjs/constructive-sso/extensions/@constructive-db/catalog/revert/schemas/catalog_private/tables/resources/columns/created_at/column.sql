-- Revert: schemas/catalog_private/tables/resources/columns/created_at/column


ALTER TABLE catalog_private.resources 
  DROP COLUMN created_at RESTRICT;