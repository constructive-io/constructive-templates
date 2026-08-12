-- Deploy: schemas/catalog_private/tables/sites_web_config/indexes/sites_web_configs_owner_scope_owner_key_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites_web_config/table
-- requires: schemas/catalog_private/tables/sites_web_config/columns/owner_key/column
-- requires: schemas/catalog_private/tables/sites_web_config/columns/owner_scope/column


CREATE INDEX sites_web_configs_owner_scope_owner_key_idx ON catalog_private.sites_web_config (owner_scope, owner_key);