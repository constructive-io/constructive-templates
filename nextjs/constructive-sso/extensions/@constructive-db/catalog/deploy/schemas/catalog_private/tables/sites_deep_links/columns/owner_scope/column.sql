-- Deploy: schemas/catalog_private/tables/sites_deep_links/columns/owner_scope/column
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites_deep_links/table


ALTER TABLE catalog_private.sites_deep_links 
  ADD COLUMN owner_scope text;