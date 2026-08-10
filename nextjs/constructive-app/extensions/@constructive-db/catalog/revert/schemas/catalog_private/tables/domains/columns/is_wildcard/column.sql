-- Revert: schemas/catalog_private/tables/domains/columns/is_wildcard/column


ALTER TABLE catalog_private.domains 
  DROP COLUMN is_wildcard RESTRICT;