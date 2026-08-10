-- Revert: schemas/catalog_private/tables/domains/constraints/domains_pkey/constraint


ALTER TABLE catalog_private.domains 
  DROP CONSTRAINT domains_pkey RESTRICT;