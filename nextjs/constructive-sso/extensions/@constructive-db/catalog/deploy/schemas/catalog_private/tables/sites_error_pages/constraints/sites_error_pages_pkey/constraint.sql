-- Deploy: schemas/catalog_private/tables/sites_error_pages/constraints/sites_error_pages_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites_error_pages/table


ALTER TABLE catalog_private.sites_error_pages 
  ADD CONSTRAINT sites_error_pages_pkey PRIMARY KEY (id);