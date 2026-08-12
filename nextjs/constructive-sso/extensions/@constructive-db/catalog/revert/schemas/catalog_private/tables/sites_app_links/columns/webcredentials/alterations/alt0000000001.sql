-- Revert: schemas/catalog_private/tables/sites_app_links/columns/webcredentials/alterations/alt0000000001


ALTER TABLE catalog_private.sites_app_links 
  ALTER COLUMN webcredentials DROP NOT NULL;