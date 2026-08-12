-- Deploy: schemas/catalog_public/tables/resource_definitions/constraints/resource_definitions_namespace_id_kind_slug_key/constraint
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/resource_definitions/table


ALTER TABLE catalog_public.resource_definitions 
  ADD CONSTRAINT resource_definitions_namespace_id_kind_slug_key 
    UNIQUE (namespace_id, kind, slug);