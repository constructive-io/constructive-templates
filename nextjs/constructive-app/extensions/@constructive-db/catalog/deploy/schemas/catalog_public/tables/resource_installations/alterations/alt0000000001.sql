-- Deploy: schemas/catalog_public/tables/resource_installations/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/resource_installations/table


ALTER TABLE catalog_public.resource_installations 
  DISABLE ROW LEVEL SECURITY;