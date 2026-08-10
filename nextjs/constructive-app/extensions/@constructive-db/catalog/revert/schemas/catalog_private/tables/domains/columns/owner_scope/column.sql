-- Revert: schemas/catalog_private/tables/domains/columns/owner_scope/column


ALTER TABLE catalog_private.domains 
  DROP COLUMN owner_scope RESTRICT;