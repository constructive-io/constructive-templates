-- Revert: schemas/catalog_private/tables/sites/columns/created_at/alterations/alt0000000001


ALTER TABLE catalog_private.sites 
  ALTER COLUMN created_at DROP DEFAULT;