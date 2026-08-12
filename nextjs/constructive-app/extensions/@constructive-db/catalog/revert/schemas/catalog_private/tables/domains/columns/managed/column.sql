-- Revert: schemas/catalog_private/tables/domains/columns/managed/column


ALTER TABLE catalog_private.domains 
  DROP COLUMN managed RESTRICT;