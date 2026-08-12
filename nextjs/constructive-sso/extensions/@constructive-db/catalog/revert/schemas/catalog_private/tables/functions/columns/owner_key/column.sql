-- Revert: schemas/catalog_private/tables/functions/columns/owner_key/column


ALTER TABLE catalog_private.functions 
  DROP COLUMN owner_key RESTRICT;