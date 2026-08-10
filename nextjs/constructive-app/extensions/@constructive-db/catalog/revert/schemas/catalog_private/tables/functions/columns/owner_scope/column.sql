-- Revert: schemas/catalog_private/tables/functions/columns/owner_scope/column


ALTER TABLE catalog_private.functions 
  DROP COLUMN owner_scope RESTRICT;