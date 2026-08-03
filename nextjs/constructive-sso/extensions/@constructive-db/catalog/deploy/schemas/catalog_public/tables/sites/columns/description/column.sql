-- Deploy: schemas/catalog_public/tables/sites/columns/description/column
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/sites/table


ALTER TABLE catalog_public.sites 
  ADD COLUMN description text;