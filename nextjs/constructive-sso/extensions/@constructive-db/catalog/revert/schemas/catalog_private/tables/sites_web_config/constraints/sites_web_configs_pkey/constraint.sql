-- Revert: schemas/catalog_private/tables/sites_web_config/constraints/sites_web_configs_pkey/constraint


ALTER TABLE catalog_private.sites_web_config 
  DROP CONSTRAINT sites_web_configs_pkey RESTRICT;