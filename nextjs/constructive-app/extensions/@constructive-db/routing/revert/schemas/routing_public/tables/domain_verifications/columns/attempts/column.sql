-- Revert: schemas/routing_public/tables/domain_verifications/columns/attempts/column


ALTER TABLE routing_public.domain_verifications 
  DROP COLUMN attempts RESTRICT;