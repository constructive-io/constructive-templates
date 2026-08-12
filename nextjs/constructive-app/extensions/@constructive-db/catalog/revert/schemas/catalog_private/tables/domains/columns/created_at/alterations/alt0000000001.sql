-- Revert: schemas/catalog_private/tables/domains/columns/created_at/alterations/alt0000000001


ALTER TABLE catalog_private.domains 
  ALTER COLUMN created_at DROP DEFAULT;