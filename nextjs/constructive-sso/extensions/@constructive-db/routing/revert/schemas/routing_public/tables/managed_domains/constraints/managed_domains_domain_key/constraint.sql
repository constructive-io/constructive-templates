-- Revert: schemas/routing_public/tables/managed_domains/constraints/managed_domains_domain_key/constraint


ALTER TABLE routing_public.managed_domains 
  DROP CONSTRAINT managed_domains_domain_key RESTRICT;