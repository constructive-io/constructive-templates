-- Revert: schemas/catalog_private/tables/sites_web_config/columns/id/alterations/alt0000000001


ALTER TABLE catalog_private.sites_web_config 
  ALTER COLUMN id DROP NOT NULL;