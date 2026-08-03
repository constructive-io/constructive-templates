-- Deploy: schemas/catalog_public/tables/domains/columns/tls_secret_name/column
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/domains/table


ALTER TABLE catalog_public.domains 
  ADD COLUMN tls_secret_name text;