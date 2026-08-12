-- Deploy: schemas/catalog_private/tables/sites_deep_links/indexes/sites_deep_links_site_id_slug_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites_deep_links/table
-- requires: schemas/catalog_private/tables/sites_deep_links/columns/slug/column
-- requires: schemas/catalog_private/tables/sites_deep_links/columns/site_id/column


CREATE UNIQUE INDEX sites_deep_links_site_id_slug_idx ON catalog_private.sites_deep_links (site_id, slug);