-- Revert: schemas/routing_public/tables/platform_domains/columns/tls_status/alterations/alt0000000004


ALTER TABLE routing_public.platform_domains 
  DROP CONSTRAINT platform_domains_tls_status_chk RESTRICT;