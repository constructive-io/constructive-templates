-- Deploy: schemas/catalog_private/tables/sites_deep_links/indexes/sites_deep_links_created_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites_deep_links/table
-- requires: schemas/catalog_private/tables/sites_deep_links/columns/created_at/column


CREATE INDEX sites_deep_links_created_at_idx ON catalog_private.sites_deep_links (created_at);