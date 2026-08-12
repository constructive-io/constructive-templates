-- Revert: schemas/catalog_private/tables/sites_app_links/constraints/sites_app_links_pkey/constraint


ALTER TABLE catalog_private.sites_app_links 
  DROP CONSTRAINT sites_app_links_pkey RESTRICT;