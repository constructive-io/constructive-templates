-- Deploy: schemas/catalog_private/tables/sites_deep_links/columns/owner_scope/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites_deep_links/columns/owner_scope/column


COMMENT ON COLUMN catalog_private.sites_deep_links.owner_scope IS 'Scope of the source table that owns the row';