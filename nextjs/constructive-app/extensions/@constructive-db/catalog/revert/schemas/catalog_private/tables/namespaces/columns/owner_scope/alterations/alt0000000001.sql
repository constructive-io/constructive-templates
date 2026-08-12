-- Revert: schemas/catalog_private/tables/namespaces/columns/owner_scope/alterations/alt0000000001


ALTER TABLE catalog_private.namespaces 
  ALTER COLUMN owner_scope DROP NOT NULL;