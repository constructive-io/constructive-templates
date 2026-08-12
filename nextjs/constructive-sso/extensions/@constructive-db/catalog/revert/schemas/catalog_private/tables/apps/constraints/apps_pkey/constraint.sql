-- Revert: schemas/catalog_private/tables/apps/constraints/apps_pkey/constraint


ALTER TABLE catalog_private.apps 
  DROP CONSTRAINT apps_pkey RESTRICT;