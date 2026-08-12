-- Revert: schemas/catalog_public/tables/domains/constraints/domains_hostname_key/constraint


ALTER TABLE catalog_public.domains 
  DROP CONSTRAINT domains_hostname_key RESTRICT;