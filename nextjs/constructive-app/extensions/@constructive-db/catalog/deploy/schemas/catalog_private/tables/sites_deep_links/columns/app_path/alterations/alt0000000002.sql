-- Deploy: schemas/catalog_private/tables/sites_deep_links/columns/app_path/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites_deep_links/columns/app_path/column


COMMENT ON COLUMN catalog_private.sites_deep_links.app_path IS 'In-app route the installed app opens, propagated from the source row';