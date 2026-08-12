-- Deploy: schemas/catalog_private/tables/sites_deep_links/columns/updated_at/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites_deep_links/table
-- requires: schemas/catalog_private/tables/sites_deep_links/columns/updated_at/column


ALTER TABLE catalog_private.sites_deep_links 
  ALTER COLUMN updated_at SET DEFAULT now();