-- Deploy: schemas/catalog_public/tables/resource_installations/constraints/resource_installations_namespace_id_slug_key/constraint
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/resource_installations/table


ALTER TABLE catalog_public.resource_installations 
  ADD CONSTRAINT resource_installations_namespace_id_slug_key 
    UNIQUE (namespace_id, slug);