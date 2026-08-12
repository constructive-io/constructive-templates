-- Deploy: schemas/catalog_private/tables/apis/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/apis/table


ALTER TABLE catalog_private.apis 
  DISABLE ROW LEVEL SECURITY;