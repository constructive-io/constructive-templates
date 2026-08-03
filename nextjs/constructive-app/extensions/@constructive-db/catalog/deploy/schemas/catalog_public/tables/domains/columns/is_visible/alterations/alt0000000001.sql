-- Deploy: schemas/catalog_public/tables/domains/columns/is_visible/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/domains/table
-- requires: schemas/catalog_public/tables/domains/columns/is_visible/column


ALTER TABLE catalog_public.domains 
  ALTER COLUMN is_visible SET NOT NULL;