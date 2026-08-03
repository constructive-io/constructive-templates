-- Deploy: schemas/catalog_public/tables/namespaces/columns/namespace_name/column
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/namespaces/table


ALTER TABLE catalog_public.namespaces 
  ADD COLUMN namespace_name text;