-- Revert: schemas/catalog_public/tables/apps/constraints/apps_pkey/constraint


ALTER TABLE catalog_public.apps 
  DROP CONSTRAINT apps_pkey RESTRICT;