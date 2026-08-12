-- Deploy: schemas/catalog_private/tables/sites_deep_links/columns/app_path/column
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites_deep_links/table


ALTER TABLE catalog_private.sites_deep_links 
  ADD COLUMN app_path text;