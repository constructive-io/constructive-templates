-- Revert: schemas/routing_public/tables/domains/columns/hostname/alterations/alt0000000003


ALTER TABLE routing_public.domains 
  DROP CONSTRAINT domains_hostname_chk RESTRICT;