-- Revert: schemas/catalog_private/tables/apps/columns/created_at/alterations/alt0000000001


ALTER TABLE catalog_private.apps 
  ALTER COLUMN created_at DROP DEFAULT;