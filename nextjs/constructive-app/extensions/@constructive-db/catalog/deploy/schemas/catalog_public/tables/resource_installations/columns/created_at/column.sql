-- Deploy: schemas/catalog_public/tables/resource_installations/columns/created_at/column
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/resource_installations/table


ALTER TABLE catalog_public.resource_installations 
  ADD COLUMN created_at timestamptz;