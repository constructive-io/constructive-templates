-- Revert: schemas/catalog_private/tables/sites/constraints/sites_pkey/constraint


ALTER TABLE catalog_private.sites 
  DROP CONSTRAINT sites_pkey RESTRICT;