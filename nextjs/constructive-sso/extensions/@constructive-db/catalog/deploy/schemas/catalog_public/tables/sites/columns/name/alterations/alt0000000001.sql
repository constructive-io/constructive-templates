-- Deploy: schemas/catalog_public/tables/sites/columns/name/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/sites/table
-- requires: schemas/catalog_public/tables/sites/columns/name/column


ALTER TABLE catalog_public.sites 
  ALTER COLUMN name SET NOT NULL;