-- Revert: schemas/catalog_private/tables/sites_app_links/columns/app_identifier/column


ALTER TABLE catalog_private.sites_app_links 
  DROP COLUMN app_identifier RESTRICT;