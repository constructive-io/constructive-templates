-- Revert: schemas/catalog_public/tables/resources/constraints/resources_pkey/constraint


ALTER TABLE catalog_public.resources 
  DROP CONSTRAINT resources_pkey RESTRICT;