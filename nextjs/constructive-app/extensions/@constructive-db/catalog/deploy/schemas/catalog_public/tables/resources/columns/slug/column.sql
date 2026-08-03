-- Deploy: schemas/catalog_public/tables/resources/columns/slug/column
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/resources/table


ALTER TABLE catalog_public.resources 
  ADD COLUMN slug text;