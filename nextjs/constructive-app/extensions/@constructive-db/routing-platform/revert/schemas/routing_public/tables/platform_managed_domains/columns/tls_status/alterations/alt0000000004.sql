-- Revert: schemas/routing_public/tables/platform_managed_domains/columns/tls_status/alterations/alt0000000004


ALTER TABLE routing_public.platform_managed_domains 
  DROP CONSTRAINT platform_managed_domains_tls_status_chk RESTRICT;