-- Revert: schemas/catalog_private/tables/functions/constraints/functions_pkey/constraint


ALTER TABLE catalog_private.functions 
  DROP CONSTRAINT functions_pkey RESTRICT;