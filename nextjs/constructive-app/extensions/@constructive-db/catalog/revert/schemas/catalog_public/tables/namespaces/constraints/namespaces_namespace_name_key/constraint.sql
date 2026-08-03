-- Revert: schemas/catalog_public/tables/namespaces/constraints/namespaces_namespace_name_key/constraint


ALTER TABLE catalog_public.namespaces 
  DROP CONSTRAINT namespaces_namespace_name_key RESTRICT;