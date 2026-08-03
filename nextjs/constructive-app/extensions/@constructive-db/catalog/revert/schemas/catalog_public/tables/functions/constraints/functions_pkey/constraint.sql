-- Revert: schemas/catalog_public/tables/functions/constraints/functions_pkey/constraint


ALTER TABLE catalog_public.functions 
  DROP CONSTRAINT functions_pkey RESTRICT;