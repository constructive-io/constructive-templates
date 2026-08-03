-- Deploy: schemas/catalog_public/tables/apps/columns/id/column
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/apps/table


ALTER TABLE catalog_public.apps 
  ADD COLUMN id uuid;