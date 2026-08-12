-- Deploy: schemas/catalog_private/tables/namespaces/columns/created_at/column
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/namespaces/table


ALTER TABLE catalog_private.namespaces 
  ADD COLUMN created_at timestamptz;