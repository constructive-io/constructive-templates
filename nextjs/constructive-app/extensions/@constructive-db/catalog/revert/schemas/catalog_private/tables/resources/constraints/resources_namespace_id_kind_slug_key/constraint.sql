-- Revert: schemas/catalog_private/tables/resources/constraints/resources_namespace_id_kind_slug_key/constraint


ALTER TABLE catalog_private.resources 
  DROP CONSTRAINT resources_namespace_id_kind_slug_key RESTRICT;