-- Revert: schemas/catalog_private/tables/sites/columns/installation_member_slug/column


ALTER TABLE catalog_private.sites 
  DROP COLUMN installation_member_slug RESTRICT;