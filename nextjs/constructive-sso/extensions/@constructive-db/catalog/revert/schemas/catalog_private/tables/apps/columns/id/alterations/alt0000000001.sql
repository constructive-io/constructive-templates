-- Revert: schemas/catalog_private/tables/apps/columns/id/alterations/alt0000000001


ALTER TABLE catalog_private.apps 
  ALTER COLUMN id DROP NOT NULL;