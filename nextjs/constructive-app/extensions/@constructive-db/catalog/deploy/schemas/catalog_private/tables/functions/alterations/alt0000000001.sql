-- Deploy: schemas/catalog_private/tables/functions/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/functions/table


ALTER TABLE catalog_private.functions 
  DISABLE ROW LEVEL SECURITY;