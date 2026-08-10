-- Deploy: schemas/catalog_private/tables/bindings/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/bindings/table


ALTER TABLE catalog_private.bindings 
  DISABLE ROW LEVEL SECURITY;