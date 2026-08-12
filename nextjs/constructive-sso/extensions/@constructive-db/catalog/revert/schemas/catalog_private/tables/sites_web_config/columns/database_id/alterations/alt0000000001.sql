-- Revert: schemas/catalog_private/tables/sites_web_config/columns/database_id/alterations/alt0000000001


ALTER TABLE catalog_private.sites_web_config 
  ALTER COLUMN database_id DROP NOT NULL;