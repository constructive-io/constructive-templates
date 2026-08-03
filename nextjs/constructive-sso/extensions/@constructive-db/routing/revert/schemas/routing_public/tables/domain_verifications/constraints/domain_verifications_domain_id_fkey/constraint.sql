-- Revert: schemas/routing_public/tables/domain_verifications/constraints/domain_verifications_domain_id_fkey/constraint


ALTER TABLE routing_public.domain_verifications 
  DROP CONSTRAINT domain_verifications_domain_id_fkey RESTRICT;