-- Deploy: schemas/catalog_public/tables/namespaces/columns/owner_key/column
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/namespaces/table


ALTER TABLE catalog_public.namespaces 
  ADD COLUMN owner_key uuid;