-- Deploy: schemas/catalog_public/tables/namespaces/columns/is_visible/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/namespaces/table
-- requires: schemas/catalog_public/tables/namespaces/columns/is_visible/column


ALTER TABLE catalog_public.namespaces 
  ALTER COLUMN is_visible SET NOT NULL;