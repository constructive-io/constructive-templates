-- Deploy: schemas/catalog_public/tables/functions/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/functions/table


ALTER TABLE catalog_public.functions 
  DISABLE ROW LEVEL SECURITY;