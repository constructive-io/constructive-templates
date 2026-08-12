-- Deploy: schemas/catalog_private/tables/sites_web_config/indexes/sites_web_config_updated_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites_web_config/table
-- requires: schemas/catalog_private/tables/sites_web_config/columns/updated_at/column


CREATE INDEX sites_web_config_updated_at_idx ON catalog_private.sites_web_config (updated_at);