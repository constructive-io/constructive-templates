-- Revert: schemas/catalog_public/tables/resources/constraints/resources_namespace_id_kind_slug_key/constraint


ALTER TABLE catalog_public.resources 
  DROP CONSTRAINT resources_namespace_id_kind_slug_key RESTRICT;