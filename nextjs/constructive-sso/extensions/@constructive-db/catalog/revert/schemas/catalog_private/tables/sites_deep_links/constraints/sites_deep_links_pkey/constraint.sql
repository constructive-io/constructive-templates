-- Revert: schemas/catalog_private/tables/sites_deep_links/constraints/sites_deep_links_pkey/constraint


ALTER TABLE catalog_private.sites_deep_links 
  DROP CONSTRAINT sites_deep_links_pkey RESTRICT;