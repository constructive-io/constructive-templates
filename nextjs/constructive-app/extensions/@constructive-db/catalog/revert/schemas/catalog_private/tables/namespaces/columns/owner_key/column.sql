-- Revert: schemas/catalog_private/tables/namespaces/columns/owner_key/column


ALTER TABLE catalog_private.namespaces 
  DROP COLUMN owner_key RESTRICT;