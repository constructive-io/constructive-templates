-- Deploy: schemas/catalog_public/tables/resources/columns/id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/resources/table
-- requires: schemas/catalog_public/tables/resources/columns/id/column


ALTER TABLE catalog_public.resources 
  ALTER COLUMN id SET NOT NULL;