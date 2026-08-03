-- Deploy: schemas/catalog_public/tables/apis/columns/id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/apis/table
-- requires: schemas/catalog_public/tables/apis/columns/id/column


ALTER TABLE catalog_public.apis 
  ALTER COLUMN id SET DEFAULT uuidv7();