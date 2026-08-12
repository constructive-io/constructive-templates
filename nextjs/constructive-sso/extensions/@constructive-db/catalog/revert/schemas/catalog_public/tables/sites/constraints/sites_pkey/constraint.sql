-- Revert: schemas/catalog_public/tables/sites/constraints/sites_pkey/constraint


ALTER TABLE catalog_public.sites 
  DROP CONSTRAINT sites_pkey RESTRICT;