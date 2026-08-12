-- Deploy: schemas/catalog_private/tables/sites/indexes/sites_owner_scope_owner_key_name_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites/table
-- requires: schemas/catalog_private/tables/sites/columns/name/column
-- requires: schemas/catalog_private/tables/sites/columns/owner_key/column
-- requires: schemas/catalog_private/tables/sites/columns/owner_scope/column


CREATE UNIQUE INDEX sites_owner_scope_owner_key_name_idx ON catalog_private.sites (owner_scope, owner_key, name) WHERE sites.owner_key IS NOT NULL;