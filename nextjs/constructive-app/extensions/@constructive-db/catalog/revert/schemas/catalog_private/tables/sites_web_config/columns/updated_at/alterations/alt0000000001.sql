-- Revert: schemas/catalog_private/tables/sites_web_config/columns/updated_at/alterations/alt0000000001


ALTER TABLE catalog_private.sites_web_config 
  ALTER COLUMN updated_at DROP DEFAULT;