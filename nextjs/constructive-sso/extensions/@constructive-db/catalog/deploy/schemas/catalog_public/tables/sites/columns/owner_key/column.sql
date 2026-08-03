-- Deploy: schemas/catalog_public/tables/sites/columns/owner_key/column
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/sites/table


ALTER TABLE catalog_public.sites 
  ADD COLUMN owner_key uuid;