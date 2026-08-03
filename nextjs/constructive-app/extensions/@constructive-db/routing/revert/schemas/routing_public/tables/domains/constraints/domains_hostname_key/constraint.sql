-- Revert: schemas/routing_public/tables/domains/constraints/domains_hostname_key/constraint


ALTER TABLE routing_public.domains 
  DROP CONSTRAINT domains_hostname_key RESTRICT;