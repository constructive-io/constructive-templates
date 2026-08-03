-- Deploy: schemas/catalog_public/tables/functions/columns/is_visible/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/functions/table
-- requires: schemas/catalog_public/tables/functions/columns/is_visible/column


ALTER TABLE catalog_public.functions 
  ALTER COLUMN is_visible SET DEFAULT false;