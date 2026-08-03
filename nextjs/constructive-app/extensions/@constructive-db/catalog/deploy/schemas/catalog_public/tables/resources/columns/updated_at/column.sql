-- Deploy: schemas/catalog_public/tables/resources/columns/updated_at/column
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/resources/table


ALTER TABLE catalog_public.resources 
  ADD COLUMN updated_at timestamptz;