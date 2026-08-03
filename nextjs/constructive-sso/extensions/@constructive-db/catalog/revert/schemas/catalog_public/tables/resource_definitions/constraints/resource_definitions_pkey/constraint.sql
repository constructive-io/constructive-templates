-- Revert: schemas/catalog_public/tables/resource_definitions/constraints/resource_definitions_pkey/constraint


ALTER TABLE catalog_public.resource_definitions 
  DROP CONSTRAINT resource_definitions_pkey RESTRICT;