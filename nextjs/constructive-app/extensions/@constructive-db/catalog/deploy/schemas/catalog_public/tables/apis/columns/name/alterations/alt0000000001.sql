-- Deploy: schemas/catalog_public/tables/apis/columns/name/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/apis/table
-- requires: schemas/catalog_public/tables/apis/columns/name/column


ALTER TABLE catalog_public.apis 
  ALTER COLUMN name SET NOT NULL;