-- Revert: schemas/catalog_private/tables/sites_app_links/columns/id/alterations/alt0000000001


ALTER TABLE catalog_private.sites_app_links 
  ALTER COLUMN id DROP NOT NULL;