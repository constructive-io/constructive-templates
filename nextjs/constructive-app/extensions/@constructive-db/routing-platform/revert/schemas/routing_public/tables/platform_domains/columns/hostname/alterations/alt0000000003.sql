-- Revert: schemas/routing_public/tables/platform_domains/columns/hostname/alterations/alt0000000003


ALTER TABLE routing_public.platform_domains 
  DROP CONSTRAINT platform_domains_hostname_chk RESTRICT;