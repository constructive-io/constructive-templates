-- Revert: schemas/catalog_private/tables/domains/columns/id/alterations/alt0000000002


ALTER TABLE catalog_private.domains 
  ALTER COLUMN id DROP DEFAULT;