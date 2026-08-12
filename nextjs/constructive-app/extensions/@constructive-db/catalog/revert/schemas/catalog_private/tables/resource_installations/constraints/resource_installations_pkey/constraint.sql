-- Revert: schemas/catalog_private/tables/resource_installations/constraints/resource_installations_pkey/constraint


ALTER TABLE catalog_private.resource_installations 
  DROP CONSTRAINT resource_installations_pkey RESTRICT;