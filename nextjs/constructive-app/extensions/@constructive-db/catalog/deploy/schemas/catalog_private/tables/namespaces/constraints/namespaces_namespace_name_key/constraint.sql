-- Deploy: schemas/catalog_private/tables/namespaces/constraints/namespaces_namespace_name_key/constraint
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/namespaces/table


ALTER TABLE catalog_private.namespaces 
  ADD CONSTRAINT namespaces_namespace_name_key 
    UNIQUE (namespace_name);