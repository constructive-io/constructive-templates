-- Deploy: schemas/catalog_public/tables/resource_definitions/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/resource_definitions/table


ALTER TABLE catalog_public.resource_definitions 
  DISABLE ROW LEVEL SECURITY;