-- Revert: schemas/catalog_private/tables/namespaces/constraints/namespaces_pkey/constraint


ALTER TABLE catalog_private.namespaces 
  DROP CONSTRAINT namespaces_pkey RESTRICT;