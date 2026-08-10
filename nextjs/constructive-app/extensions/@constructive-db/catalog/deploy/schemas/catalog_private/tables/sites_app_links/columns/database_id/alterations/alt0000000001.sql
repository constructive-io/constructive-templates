-- Deploy: schemas/catalog_private/tables/sites_app_links/columns/database_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites_app_links/table
-- requires: schemas/catalog_private/tables/sites_app_links/columns/database_id/column


ALTER TABLE catalog_private.sites_app_links 
  ALTER COLUMN database_id SET NOT NULL;