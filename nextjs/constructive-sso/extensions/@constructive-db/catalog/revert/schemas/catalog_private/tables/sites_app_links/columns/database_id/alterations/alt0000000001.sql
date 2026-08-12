-- Revert: schemas/catalog_private/tables/sites_app_links/columns/database_id/alterations/alt0000000001


ALTER TABLE catalog_private.sites_app_links 
  ALTER COLUMN database_id DROP NOT NULL;