-- Revert: schemas/routing_public/tables/platform_domains/columns/verification_status/alterations/alt0000000004


ALTER TABLE routing_public.platform_domains 
  DROP CONSTRAINT platform_domains_verification_status_chk RESTRICT;