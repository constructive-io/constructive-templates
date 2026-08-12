-- Revert: schemas/catalog_private/tables/sites/columns/updated_at/alterations/alt0000000001


ALTER TABLE catalog_private.sites 
  ALTER COLUMN updated_at DROP DEFAULT;