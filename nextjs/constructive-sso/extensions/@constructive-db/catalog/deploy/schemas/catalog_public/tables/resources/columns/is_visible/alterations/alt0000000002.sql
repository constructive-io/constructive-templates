-- Deploy: schemas/catalog_public/tables/resources/columns/is_visible/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/resources/table
-- requires: schemas/catalog_public/tables/resources/columns/is_visible/column


ALTER TABLE catalog_public.resources 
  ALTER COLUMN is_visible SET DEFAULT false;