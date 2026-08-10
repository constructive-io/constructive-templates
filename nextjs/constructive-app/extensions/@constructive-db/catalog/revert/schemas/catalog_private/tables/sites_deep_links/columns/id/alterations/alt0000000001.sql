-- Revert: schemas/catalog_private/tables/sites_deep_links/columns/id/alterations/alt0000000001


ALTER TABLE catalog_private.sites_deep_links 
  ALTER COLUMN id DROP NOT NULL;