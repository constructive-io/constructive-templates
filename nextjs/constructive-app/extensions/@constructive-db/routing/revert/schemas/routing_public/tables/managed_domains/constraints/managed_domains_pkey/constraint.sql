-- Revert: schemas/routing_public/tables/managed_domains/constraints/managed_domains_pkey/constraint


ALTER TABLE routing_public.managed_domains 
  DROP CONSTRAINT managed_domains_pkey RESTRICT;