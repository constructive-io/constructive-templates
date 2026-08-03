-- Revert: schemas/routing_public/tables/domain_verifications/columns/domain_id/alterations/alt0000000002


ALTER TABLE routing_public.domain_verifications 
  DROP CONSTRAINT domain_verifications_domain_id_managed_domain_id_chk RESTRICT;