-- Revert: schemas/catalog_private/tables/namespaces/constraints/namespaces_namespace_name_key/constraint


ALTER TABLE catalog_private.namespaces 
  DROP CONSTRAINT namespaces_namespace_name_key RESTRICT;