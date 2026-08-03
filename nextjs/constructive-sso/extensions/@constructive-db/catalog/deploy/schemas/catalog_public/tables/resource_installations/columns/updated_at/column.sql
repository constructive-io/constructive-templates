-- Deploy: schemas/catalog_public/tables/resource_installations/columns/updated_at/column
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/resource_installations/table


ALTER TABLE catalog_public.resource_installations 
  ADD COLUMN updated_at timestamptz;