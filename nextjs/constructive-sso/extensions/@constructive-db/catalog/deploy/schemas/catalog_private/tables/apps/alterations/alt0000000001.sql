-- Deploy: schemas/catalog_private/tables/apps/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/apps/table


ALTER TABLE catalog_private.apps 
  DISABLE ROW LEVEL SECURITY;