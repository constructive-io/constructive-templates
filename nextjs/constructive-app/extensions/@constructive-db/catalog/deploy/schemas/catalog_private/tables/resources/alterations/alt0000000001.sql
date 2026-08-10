-- Deploy: schemas/catalog_private/tables/resources/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/resources/table


ALTER TABLE catalog_private.resources 
  DISABLE ROW LEVEL SECURITY;