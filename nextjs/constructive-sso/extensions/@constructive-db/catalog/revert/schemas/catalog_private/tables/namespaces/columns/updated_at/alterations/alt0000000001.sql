-- Revert: schemas/catalog_private/tables/namespaces/columns/updated_at/alterations/alt0000000001


ALTER TABLE catalog_private.namespaces 
  ALTER COLUMN updated_at DROP DEFAULT;