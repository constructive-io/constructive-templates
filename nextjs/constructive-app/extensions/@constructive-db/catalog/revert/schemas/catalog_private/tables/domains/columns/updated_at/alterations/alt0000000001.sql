-- Revert: schemas/catalog_private/tables/domains/columns/updated_at/alterations/alt0000000001


ALTER TABLE catalog_private.domains 
  ALTER COLUMN updated_at DROP DEFAULT;