-- Revert: schemas/catalog_private/tables/namespaces/columns/id/alterations/alt0000000001


ALTER TABLE catalog_private.namespaces 
  ALTER COLUMN id DROP NOT NULL;