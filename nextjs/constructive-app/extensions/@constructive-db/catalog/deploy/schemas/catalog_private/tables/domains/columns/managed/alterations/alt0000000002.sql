-- Deploy: schemas/catalog_private/tables/domains/columns/managed/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/domains/table
-- requires: schemas/catalog_private/tables/domains/columns/managed/column


ALTER TABLE catalog_private.domains 
  ALTER COLUMN managed SET DEFAULT false;