-- Revert: schemas/routing_public/tables/domain_verifications/constraints/domain_verifications_pkey/constraint


ALTER TABLE routing_public.domain_verifications 
  DROP CONSTRAINT domain_verifications_pkey RESTRICT;