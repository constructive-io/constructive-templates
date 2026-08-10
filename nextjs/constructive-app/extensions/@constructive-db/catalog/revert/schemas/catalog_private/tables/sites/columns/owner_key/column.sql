-- Revert: schemas/catalog_private/tables/sites/columns/owner_key/column


ALTER TABLE catalog_private.sites 
  DROP COLUMN owner_key RESTRICT;