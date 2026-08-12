-- Revert: schemas/catalog_private/tables/resources/columns/owner_scope/column


ALTER TABLE catalog_private.resources 
  DROP COLUMN owner_scope RESTRICT;