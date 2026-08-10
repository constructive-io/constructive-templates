-- Deploy: schemas/catalog_private/tables/namespaces/columns/owner_scope/column
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/namespaces/table


ALTER TABLE catalog_private.namespaces 
  ADD COLUMN owner_scope text;