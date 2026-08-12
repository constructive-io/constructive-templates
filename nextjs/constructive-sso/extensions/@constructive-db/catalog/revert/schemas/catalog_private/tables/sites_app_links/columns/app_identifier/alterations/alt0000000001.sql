-- Revert: schemas/catalog_private/tables/sites_app_links/columns/app_identifier/alterations/alt0000000001


ALTER TABLE catalog_private.sites_app_links 
  ALTER COLUMN app_identifier DROP NOT NULL;