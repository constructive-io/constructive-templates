-- Revert: schemas/catalog_private/tables/apis/columns/id/column


ALTER TABLE catalog_private.apis 
  DROP COLUMN id RESTRICT;