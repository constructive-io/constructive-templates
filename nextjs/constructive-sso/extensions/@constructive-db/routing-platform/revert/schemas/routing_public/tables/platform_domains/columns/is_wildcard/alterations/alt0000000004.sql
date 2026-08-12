-- Revert: schemas/routing_public/tables/platform_domains/columns/is_wildcard/alterations/alt0000000004


ALTER TABLE routing_public.platform_domains 
  DROP CONSTRAINT platform_domains_is_wildcard_hostname_parent_hostname_chk RESTRICT;