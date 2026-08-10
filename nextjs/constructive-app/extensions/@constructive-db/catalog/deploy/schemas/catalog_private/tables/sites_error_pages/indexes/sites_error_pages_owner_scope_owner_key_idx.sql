-- Deploy: schemas/catalog_private/tables/sites_error_pages/indexes/sites_error_pages_owner_scope_owner_key_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites_error_pages/table
-- requires: schemas/catalog_private/tables/sites_error_pages/columns/owner_key/column
-- requires: schemas/catalog_private/tables/sites_error_pages/columns/owner_scope/column


CREATE INDEX sites_error_pages_owner_scope_owner_key_idx ON catalog_private.sites_error_pages (owner_scope, owner_key);