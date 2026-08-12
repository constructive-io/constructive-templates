-- Revert: schemas/catalog_private/tables/resources/constraints/resources_pkey/constraint


ALTER TABLE catalog_private.resources 
  DROP CONSTRAINT resources_pkey RESTRICT;