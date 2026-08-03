-- Deploy: schemas/catalog_public/tables/namespaces/columns/updated_at/column
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/namespaces/table


ALTER TABLE catalog_public.namespaces 
  ADD COLUMN updated_at timestamptz;