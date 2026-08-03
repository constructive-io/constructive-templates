-- Deploy: schemas/catalog_public/tables/namespaces/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/namespaces/table


ALTER TABLE catalog_public.namespaces 
  DISABLE ROW LEVEL SECURITY;