-- Revert: schemas/catalog_private/tables/apis/constraints/apis_pkey/constraint


ALTER TABLE catalog_private.apis 
  DROP CONSTRAINT apis_pkey RESTRICT;