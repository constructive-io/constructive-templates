-- Deploy: schemas/catalog_public/tables/sites/columns/title/column
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/sites/table


ALTER TABLE catalog_public.sites 
  ADD COLUMN title text;