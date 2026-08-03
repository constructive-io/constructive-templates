-- Deploy: schemas/catalog_public/tables/apps/columns/id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/apps/table
-- requires: schemas/catalog_public/tables/apps/columns/id/column


ALTER TABLE catalog_public.apps 
  ALTER COLUMN id SET DEFAULT uuidv7();