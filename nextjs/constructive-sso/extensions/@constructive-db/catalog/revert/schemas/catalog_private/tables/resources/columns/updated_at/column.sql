-- Revert: schemas/catalog_private/tables/resources/columns/updated_at/column


ALTER TABLE catalog_private.resources 
  DROP COLUMN updated_at RESTRICT;