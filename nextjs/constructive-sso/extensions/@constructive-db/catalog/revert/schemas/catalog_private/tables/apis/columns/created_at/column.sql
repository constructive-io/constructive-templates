-- Revert: schemas/catalog_private/tables/apis/columns/created_at/column


ALTER TABLE catalog_private.apis 
  DROP COLUMN created_at RESTRICT;