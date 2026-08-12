-- Revert: schemas/catalog_private/tables/apis/columns/owner_key/column


ALTER TABLE catalog_private.apis 
  DROP COLUMN owner_key RESTRICT;