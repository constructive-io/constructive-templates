-- Deploy: schemas/catalog_private/tables/sites_app_links/columns/app_identifier/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites_app_links/table
-- requires: schemas/catalog_private/tables/sites_app_links/columns/app_identifier/column


ALTER TABLE catalog_private.sites_app_links 
  ALTER COLUMN app_identifier SET NOT NULL;