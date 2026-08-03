-- Deploy: schemas/catalog_public/tables/resources/columns/database_id/column
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/resources/table


ALTER TABLE catalog_public.resources 
  ADD COLUMN database_id uuid;