-- Revert: schemas/catalog_private/tables/domains/columns/is_wildcard/alterations/alt0000000002


ALTER TABLE catalog_private.domains 
  ALTER COLUMN is_wildcard DROP DEFAULT;