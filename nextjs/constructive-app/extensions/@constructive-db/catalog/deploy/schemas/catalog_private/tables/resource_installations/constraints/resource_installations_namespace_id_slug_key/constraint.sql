-- Deploy: schemas/catalog_private/tables/resource_installations/constraints/resource_installations_namespace_id_slug_key/constraint
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/resource_installations/table


ALTER TABLE catalog_private.resource_installations 
  ADD CONSTRAINT resource_installations_namespace_id_slug_key 
    UNIQUE (namespace_id, slug);