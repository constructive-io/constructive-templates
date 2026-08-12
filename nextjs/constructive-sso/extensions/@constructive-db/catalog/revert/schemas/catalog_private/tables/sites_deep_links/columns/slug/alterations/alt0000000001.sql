-- Revert: schemas/catalog_private/tables/sites_deep_links/columns/slug/alterations/alt0000000001


ALTER TABLE catalog_private.sites_deep_links 
  ALTER COLUMN slug DROP NOT NULL;