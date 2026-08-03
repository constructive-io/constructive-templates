-- Deploy: schemas/catalog_public/tables/functions/columns/created_at/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/functions/table
-- requires: schemas/catalog_public/tables/functions/columns/created_at/column


ALTER TABLE catalog_public.functions 
  ALTER COLUMN created_at SET DEFAULT now();