-- Deploy: schemas/catalog_private/tables/sites_app_links/indexes/sites_app_links_owner_scope_owner_key_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites_app_links/table
-- requires: schemas/catalog_private/tables/sites_app_links/columns/owner_key/column
-- requires: schemas/catalog_private/tables/sites_app_links/columns/owner_scope/column


CREATE INDEX sites_app_links_owner_scope_owner_key_idx ON catalog_private.sites_app_links (owner_scope, owner_key);