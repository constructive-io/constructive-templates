-- Deploy: schemas/catalog_public/tables/apis/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/apis/table


ALTER TABLE catalog_public.apis 
  DISABLE ROW LEVEL SECURITY;