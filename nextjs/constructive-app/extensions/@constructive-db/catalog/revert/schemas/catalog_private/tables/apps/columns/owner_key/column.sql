-- Revert: schemas/catalog_private/tables/apps/columns/owner_key/column


ALTER TABLE catalog_private.apps 
  DROP COLUMN owner_key RESTRICT;