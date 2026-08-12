-- Revert: schemas/catalog_private/tables/apps/columns/owner_scope/alterations/alt0000000001


ALTER TABLE catalog_private.apps 
  ALTER COLUMN owner_scope DROP NOT NULL;