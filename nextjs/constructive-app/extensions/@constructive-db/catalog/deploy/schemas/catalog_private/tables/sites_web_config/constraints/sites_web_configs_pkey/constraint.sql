-- Deploy: schemas/catalog_private/tables/sites_web_config/constraints/sites_web_configs_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites_web_config/table


ALTER TABLE catalog_private.sites_web_config 
  ADD CONSTRAINT sites_web_configs_pkey PRIMARY KEY (id);