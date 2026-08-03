-- Deploy: schemas/catalog_public/tables/apis/columns/updated_at/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/apis/table
-- requires: schemas/catalog_public/tables/apis/columns/updated_at/column


ALTER TABLE catalog_public.apis 
  ALTER COLUMN updated_at SET DEFAULT now();