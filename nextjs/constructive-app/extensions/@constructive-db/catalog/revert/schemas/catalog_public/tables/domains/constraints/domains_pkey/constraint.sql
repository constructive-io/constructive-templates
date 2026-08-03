-- Revert: schemas/catalog_public/tables/domains/constraints/domains_pkey/constraint


ALTER TABLE catalog_public.domains 
  DROP CONSTRAINT domains_pkey RESTRICT;