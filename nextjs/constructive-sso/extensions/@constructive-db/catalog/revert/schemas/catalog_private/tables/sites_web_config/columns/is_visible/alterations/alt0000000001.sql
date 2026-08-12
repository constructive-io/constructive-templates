-- Revert: schemas/catalog_private/tables/sites_web_config/columns/is_visible/alterations/alt0000000001


ALTER TABLE catalog_private.sites_web_config 
  ALTER COLUMN is_visible DROP NOT NULL;