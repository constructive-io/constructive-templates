-- Revert: schemas/catalog_private/tables/sites/columns/id/alterations/alt0000000001


ALTER TABLE catalog_private.sites 
  ALTER COLUMN id DROP NOT NULL;