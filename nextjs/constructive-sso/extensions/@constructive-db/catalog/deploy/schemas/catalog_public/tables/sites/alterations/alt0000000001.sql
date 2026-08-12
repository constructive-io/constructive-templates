-- Deploy: schemas/catalog_public/tables/sites/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/sites/table


ALTER TABLE catalog_public.sites 
  DISABLE ROW LEVEL SECURITY;