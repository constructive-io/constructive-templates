-- Revert: schemas/routing_public/tables/platform_managed_domains/constraints/platform_managed_domains_domain_key/constraint


ALTER TABLE routing_public.platform_managed_domains 
  DROP CONSTRAINT platform_managed_domains_domain_key RESTRICT;