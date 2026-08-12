-- Deploy: schemas/catalog_public/tables/functions/columns/id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/functions/table
-- requires: schemas/catalog_public/tables/functions/columns/id/column


ALTER TABLE catalog_public.functions 
  ALTER COLUMN id SET NOT NULL;