-- Revert: schemas/catalog_private/tables/apis/columns/dbname/column


ALTER TABLE catalog_private.apis 
  DROP COLUMN dbname RESTRICT;