-- Deploy: schemas/catalog_public/tables/namespaces/constraints/namespaces_namespace_name_key/constraint
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/namespaces/table


ALTER TABLE catalog_public.namespaces 
  ADD CONSTRAINT namespaces_namespace_name_key 
    UNIQUE (namespace_name);