-- Deploy: schemas/catalog_private/tables/resources/constraints/resources_namespace_id_kind_slug_key/constraint
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/resources/table


ALTER TABLE catalog_private.resources 
  ADD CONSTRAINT resources_namespace_id_kind_slug_key 
    UNIQUE (namespace_id, kind, slug);