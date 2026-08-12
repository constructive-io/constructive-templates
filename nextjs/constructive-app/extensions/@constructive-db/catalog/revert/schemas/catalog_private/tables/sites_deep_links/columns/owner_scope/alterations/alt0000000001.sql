-- Revert: schemas/catalog_private/tables/sites_deep_links/columns/owner_scope/alterations/alt0000000001


ALTER TABLE catalog_private.sites_deep_links 
  ALTER COLUMN owner_scope DROP NOT NULL;