-- Revert: schemas/routing_public/tables/domains/columns/tls_status/alterations/alt0000000004


ALTER TABLE routing_public.domains 
  DROP CONSTRAINT domains_tls_status_chk RESTRICT;