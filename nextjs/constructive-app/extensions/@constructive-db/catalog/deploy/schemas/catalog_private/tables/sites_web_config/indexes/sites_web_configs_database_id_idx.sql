-- Deploy: schemas/catalog_private/tables/sites_web_config/indexes/sites_web_configs_database_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites_web_config/table
-- requires: schemas/catalog_private/tables/sites_web_config/columns/database_id/column


CREATE INDEX sites_web_configs_database_id_idx ON catalog_private.sites_web_config (database_id);