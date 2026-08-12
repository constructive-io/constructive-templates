-- Revert: schemas/catalog_private/tables/apis/columns/updated_at/column


ALTER TABLE catalog_private.apis 
  DROP COLUMN updated_at RESTRICT;