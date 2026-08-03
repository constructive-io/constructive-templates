-- Revert: schemas/routing_public/tables/domains/constraints/domains_pkey/constraint


ALTER TABLE routing_public.domains 
  DROP CONSTRAINT domains_pkey RESTRICT;