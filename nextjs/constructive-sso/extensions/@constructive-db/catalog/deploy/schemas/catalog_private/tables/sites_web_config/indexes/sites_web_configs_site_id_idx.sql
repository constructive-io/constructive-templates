-- Deploy: schemas/catalog_private/tables/sites_web_config/indexes/sites_web_configs_site_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites_web_config/table
-- requires: schemas/catalog_private/tables/sites_web_config/columns/site_id/column


CREATE UNIQUE INDEX sites_web_configs_site_id_idx ON catalog_private.sites_web_config (site_id);