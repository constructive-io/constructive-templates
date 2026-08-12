-- Deploy: schemas/catalog_private/tables/sites_deep_links/columns/id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites_deep_links/table
-- requires: schemas/catalog_private/tables/sites_deep_links/columns/id/column


ALTER TABLE catalog_private.sites_deep_links 
  ALTER COLUMN id SET DEFAULT uuidv7();