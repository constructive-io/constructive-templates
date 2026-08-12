-- Revert: schemas/catalog_private/tables/namespaces/columns/namespace_name/alterations/alt0000000001


ALTER TABLE catalog_private.namespaces 
  ALTER COLUMN namespace_name DROP NOT NULL;