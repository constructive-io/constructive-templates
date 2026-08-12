-- Deploy: schemas/catalog_private/tables/resource_definitions/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/resource_definitions/table


ALTER TABLE catalog_private.resource_definitions 
  DISABLE ROW LEVEL SECURITY;