-- Deploy: schemas/catalog_private/tables/sites_app_links/columns/path_components/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites_app_links/table
-- requires: schemas/catalog_private/tables/sites_app_links/columns/path_components/column


ALTER TABLE catalog_private.sites_app_links 
  ALTER COLUMN path_components SET DEFAULT CAST(ARRAY[] AS text[]);