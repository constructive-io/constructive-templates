-- Deploy: schemas/catalog_public/tables/namespaces/columns/id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/namespaces/table
-- requires: schemas/catalog_public/tables/namespaces/columns/id/column


ALTER TABLE catalog_public.namespaces 
  ALTER COLUMN id SET DEFAULT uuidv7();