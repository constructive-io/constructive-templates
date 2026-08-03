-- Deploy: schemas/catalog_public/tables/sites/columns/id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/sites/table
-- requires: schemas/catalog_public/tables/sites/columns/id/column


ALTER TABLE catalog_public.sites 
  ALTER COLUMN id SET DEFAULT uuidv7();