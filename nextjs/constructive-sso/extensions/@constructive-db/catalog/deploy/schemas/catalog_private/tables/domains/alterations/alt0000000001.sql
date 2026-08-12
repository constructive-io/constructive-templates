-- Deploy: schemas/catalog_private/tables/domains/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/domains/table


ALTER TABLE catalog_private.domains 
  DISABLE ROW LEVEL SECURITY;