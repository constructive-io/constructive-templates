-- Revert: schemas/catalog_private/tables/namespaces/columns/created_at/alterations/alt0000000001


ALTER TABLE catalog_private.namespaces 
  ALTER COLUMN created_at DROP DEFAULT;