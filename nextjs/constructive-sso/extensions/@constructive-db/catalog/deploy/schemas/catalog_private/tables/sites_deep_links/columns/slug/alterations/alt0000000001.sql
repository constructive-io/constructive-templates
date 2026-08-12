-- Deploy: schemas/catalog_private/tables/sites_deep_links/columns/slug/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites_deep_links/table
-- requires: schemas/catalog_private/tables/sites_deep_links/columns/slug/column


ALTER TABLE catalog_private.sites_deep_links 
  ALTER COLUMN slug SET NOT NULL;