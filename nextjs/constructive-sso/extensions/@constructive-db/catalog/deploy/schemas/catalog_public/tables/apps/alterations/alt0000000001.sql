-- Deploy: schemas/catalog_public/tables/apps/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/apps/table


ALTER TABLE catalog_public.apps 
  DISABLE ROW LEVEL SECURITY;