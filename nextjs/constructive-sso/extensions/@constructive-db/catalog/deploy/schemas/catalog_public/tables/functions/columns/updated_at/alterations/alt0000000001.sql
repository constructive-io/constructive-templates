-- Deploy: schemas/catalog_public/tables/functions/columns/updated_at/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/functions/table
-- requires: schemas/catalog_public/tables/functions/columns/updated_at/column


ALTER TABLE catalog_public.functions 
  ALTER COLUMN updated_at SET DEFAULT now();