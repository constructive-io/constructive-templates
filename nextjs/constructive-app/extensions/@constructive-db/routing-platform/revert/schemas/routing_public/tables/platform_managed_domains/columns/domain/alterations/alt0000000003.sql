-- Revert: schemas/routing_public/tables/platform_managed_domains/columns/domain/alterations/alt0000000003


ALTER TABLE routing_public.platform_managed_domains 
  DROP CONSTRAINT platform_managed_domains_domain_chk RESTRICT;