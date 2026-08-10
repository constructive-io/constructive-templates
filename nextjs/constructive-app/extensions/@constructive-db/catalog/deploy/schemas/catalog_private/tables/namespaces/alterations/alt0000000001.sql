-- Deploy: schemas/catalog_private/tables/namespaces/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/namespaces/table


ALTER TABLE catalog_private.namespaces 
  DISABLE ROW LEVEL SECURITY;