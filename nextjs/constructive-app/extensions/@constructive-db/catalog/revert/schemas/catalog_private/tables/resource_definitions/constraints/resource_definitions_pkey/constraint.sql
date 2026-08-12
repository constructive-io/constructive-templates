-- Revert: schemas/catalog_private/tables/resource_definitions/constraints/resource_definitions_pkey/constraint


ALTER TABLE catalog_private.resource_definitions 
  DROP CONSTRAINT resource_definitions_pkey RESTRICT;