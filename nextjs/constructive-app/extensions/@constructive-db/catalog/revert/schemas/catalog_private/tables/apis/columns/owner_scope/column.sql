-- Revert: schemas/catalog_private/tables/apis/columns/owner_scope/column


ALTER TABLE catalog_private.apis 
  DROP COLUMN owner_scope RESTRICT;