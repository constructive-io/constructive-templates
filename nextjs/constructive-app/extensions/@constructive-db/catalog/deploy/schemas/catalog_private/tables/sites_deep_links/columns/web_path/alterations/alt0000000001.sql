-- Deploy: schemas/catalog_private/tables/sites_deep_links/columns/web_path/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites_deep_links/columns/web_path/column


COMMENT ON COLUMN catalog_private.sites_deep_links.web_path IS 'Web fallback path on the owning site, propagated from the source row';