-- Revert: schemas/routing_public/tables/platform_domains/constraints/platform_domains_hostname_key/constraint


ALTER TABLE routing_public.platform_domains 
  DROP CONSTRAINT platform_domains_hostname_key RESTRICT;