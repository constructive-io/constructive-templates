-- Revert: schemas/routing_public/tables/managed_domains/columns/cert_status/alterations/alt0000000004


ALTER TABLE routing_public.managed_domains 
  DROP CONSTRAINT managed_domains_cert_status_chk RESTRICT;