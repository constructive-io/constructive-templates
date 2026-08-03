-- Deploy: schemas/catalog_public/tables/resources/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/resources/table


ALTER TABLE catalog_public.resources 
  DISABLE ROW LEVEL SECURITY;