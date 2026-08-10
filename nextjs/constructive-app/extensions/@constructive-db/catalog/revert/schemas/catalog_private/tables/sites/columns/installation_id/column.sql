-- Revert: schemas/catalog_private/tables/sites/columns/installation_id/column


ALTER TABLE catalog_private.sites 
  DROP COLUMN installation_id RESTRICT;