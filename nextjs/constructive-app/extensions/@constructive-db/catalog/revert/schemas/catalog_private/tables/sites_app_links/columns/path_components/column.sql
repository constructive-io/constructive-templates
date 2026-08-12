-- Revert: schemas/catalog_private/tables/sites_app_links/columns/path_components/column


ALTER TABLE catalog_private.sites_app_links 
  DROP COLUMN path_components RESTRICT;