-- Revert: schemas/catalog_public/tables/apis/constraints/apis_pkey/constraint


ALTER TABLE catalog_public.apis 
  DROP CONSTRAINT apis_pkey RESTRICT;