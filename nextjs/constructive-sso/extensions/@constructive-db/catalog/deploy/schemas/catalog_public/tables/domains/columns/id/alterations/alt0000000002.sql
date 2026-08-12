-- Deploy: schemas/catalog_public/tables/domains/columns/id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/domains/table
-- requires: schemas/catalog_public/tables/domains/columns/id/column


ALTER TABLE catalog_public.domains 
  ALTER COLUMN id SET DEFAULT uuidv7();