-- Revert: schemas/catalog_public/tables/namespaces/constraints/namespaces_pkey/constraint


ALTER TABLE catalog_public.namespaces 
  DROP CONSTRAINT namespaces_pkey RESTRICT;