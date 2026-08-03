-- Revert: schemas/catalog_public/tables/resource_installations/constraints/resource_installations_pkey/constraint


ALTER TABLE catalog_public.resource_installations 
  DROP CONSTRAINT resource_installations_pkey RESTRICT;