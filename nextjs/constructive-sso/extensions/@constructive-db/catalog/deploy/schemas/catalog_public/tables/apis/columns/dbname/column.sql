-- Deploy: schemas/catalog_public/tables/apis/columns/dbname/column
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/apis/table


ALTER TABLE catalog_public.apis 
  ADD COLUMN dbname text;