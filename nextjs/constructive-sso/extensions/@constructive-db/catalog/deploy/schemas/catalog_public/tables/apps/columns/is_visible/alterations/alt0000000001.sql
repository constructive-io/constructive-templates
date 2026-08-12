-- Deploy: schemas/catalog_public/tables/apps/columns/is_visible/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/apps/table
-- requires: schemas/catalog_public/tables/apps/columns/is_visible/column


ALTER TABLE catalog_public.apps 
  ALTER COLUMN is_visible SET NOT NULL;