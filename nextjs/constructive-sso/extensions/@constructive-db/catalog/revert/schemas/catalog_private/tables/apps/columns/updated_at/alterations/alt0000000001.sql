-- Revert: schemas/catalog_private/tables/apps/columns/updated_at/alterations/alt0000000001


ALTER TABLE catalog_private.apps 
  ALTER COLUMN updated_at DROP DEFAULT;