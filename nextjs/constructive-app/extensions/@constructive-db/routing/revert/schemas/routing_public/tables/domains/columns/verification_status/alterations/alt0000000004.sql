-- Revert: schemas/routing_public/tables/domains/columns/verification_status/alterations/alt0000000004


ALTER TABLE routing_public.domains 
  DROP CONSTRAINT domains_verification_status_chk RESTRICT;