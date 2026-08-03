-- Deploy: schemas/catalog_public/tables/functions/columns/updated_at/column
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/functions/table


ALTER TABLE catalog_public.functions 
  ADD COLUMN updated_at timestamptz;