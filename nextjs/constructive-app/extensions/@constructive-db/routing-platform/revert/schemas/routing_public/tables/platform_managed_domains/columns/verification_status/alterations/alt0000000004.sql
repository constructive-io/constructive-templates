-- Revert: schemas/routing_public/tables/platform_managed_domains/columns/verification_status/alterations/alt0000000004


ALTER TABLE routing_public.platform_managed_domains 
  DROP CONSTRAINT platform_managed_domains_verification_status_chk RESTRICT;