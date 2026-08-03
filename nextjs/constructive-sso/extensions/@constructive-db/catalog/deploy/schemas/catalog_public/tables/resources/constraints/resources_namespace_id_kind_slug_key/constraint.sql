-- Deploy: schemas/catalog_public/tables/resources/constraints/resources_namespace_id_kind_slug_key/constraint
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/resources/table


ALTER TABLE catalog_public.resources 
  ADD CONSTRAINT resources_namespace_id_kind_slug_key 
    UNIQUE (namespace_id, kind, slug);