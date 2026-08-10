-- Deploy: schemas/catalog_private/tables/sites_app_links/constraints/sites_app_links_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites_app_links/table


ALTER TABLE catalog_private.sites_app_links 
  ADD CONSTRAINT sites_app_links_pkey PRIMARY KEY (id);