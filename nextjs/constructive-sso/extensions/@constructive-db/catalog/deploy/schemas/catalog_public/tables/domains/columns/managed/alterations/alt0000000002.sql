-- Deploy: schemas/catalog_public/tables/domains/columns/managed/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/domains/table
-- requires: schemas/catalog_public/tables/domains/columns/managed/column


ALTER TABLE catalog_public.domains 
  ALTER COLUMN managed SET DEFAULT false;