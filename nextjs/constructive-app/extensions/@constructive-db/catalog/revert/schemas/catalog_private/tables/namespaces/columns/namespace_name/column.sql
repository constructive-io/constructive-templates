-- Revert: schemas/catalog_private/tables/namespaces/columns/namespace_name/column


ALTER TABLE catalog_private.namespaces 
  DROP COLUMN namespace_name RESTRICT;