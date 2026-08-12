-- Revert: schemas/catalog_private/tables/domains/columns/owner_key/column


ALTER TABLE catalog_private.domains 
  DROP COLUMN owner_key RESTRICT;