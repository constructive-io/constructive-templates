-- Revert: schemas/catalog_private/tables/domains/constraints/domains_hostname_key/constraint


ALTER TABLE catalog_private.domains 
  DROP CONSTRAINT domains_hostname_key RESTRICT;