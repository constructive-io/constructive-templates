-- Revert: schemas/routing_public/tables/domains/columns/is_wildcard/alterations/alt0000000004


ALTER TABLE routing_public.domains 
  DROP CONSTRAINT domains_is_wildcard_hostname_parent_hostname_chk RESTRICT;