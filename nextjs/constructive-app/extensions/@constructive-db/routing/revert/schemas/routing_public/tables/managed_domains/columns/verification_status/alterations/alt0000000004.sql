-- Revert: schemas/routing_public/tables/managed_domains/columns/verification_status/alterations/alt0000000004


ALTER TABLE routing_public.managed_domains 
  DROP CONSTRAINT managed_domains_verification_status_chk RESTRICT;