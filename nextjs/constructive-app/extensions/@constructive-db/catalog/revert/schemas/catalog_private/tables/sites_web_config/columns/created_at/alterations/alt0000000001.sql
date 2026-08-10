-- Revert: schemas/catalog_private/tables/sites_web_config/columns/created_at/alterations/alt0000000001


ALTER TABLE catalog_private.sites_web_config 
  ALTER COLUMN created_at DROP DEFAULT;