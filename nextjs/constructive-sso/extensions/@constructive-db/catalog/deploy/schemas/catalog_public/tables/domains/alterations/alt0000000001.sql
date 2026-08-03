-- Deploy: schemas/catalog_public/tables/domains/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/domains/table


ALTER TABLE catalog_public.domains 
  DISABLE ROW LEVEL SECURITY;