-- Revert: schemas/catalog_private/tables/resources/columns/owner_key/column


ALTER TABLE catalog_private.resources 
  DROP COLUMN owner_key RESTRICT;