-- Revert: schemas/catalog_private/tables/sites_error_pages/constraints/sites_error_pages_pkey/constraint


ALTER TABLE catalog_private.sites_error_pages 
  DROP CONSTRAINT sites_error_pages_pkey RESTRICT;