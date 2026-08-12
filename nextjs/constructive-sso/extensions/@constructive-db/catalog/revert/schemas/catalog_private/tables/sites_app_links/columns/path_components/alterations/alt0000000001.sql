-- Revert: schemas/catalog_private/tables/sites_app_links/columns/path_components/alterations/alt0000000001


ALTER TABLE catalog_private.sites_app_links 
  ALTER COLUMN path_components DROP NOT NULL;