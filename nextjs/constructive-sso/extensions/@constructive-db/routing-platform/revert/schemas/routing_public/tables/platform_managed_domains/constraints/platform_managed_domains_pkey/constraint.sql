-- Revert: schemas/routing_public/tables/platform_managed_domains/constraints/platform_managed_domains_pkey/constraint


ALTER TABLE routing_public.platform_managed_domains 
  DROP CONSTRAINT platform_managed_domains_pkey RESTRICT;