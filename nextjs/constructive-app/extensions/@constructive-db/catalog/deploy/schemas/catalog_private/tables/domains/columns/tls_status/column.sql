-- Deploy: schemas/catalog_private/tables/domains/columns/tls_status/column
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/domains/table


ALTER TABLE catalog_private.domains 
  ADD COLUMN tls_status text;