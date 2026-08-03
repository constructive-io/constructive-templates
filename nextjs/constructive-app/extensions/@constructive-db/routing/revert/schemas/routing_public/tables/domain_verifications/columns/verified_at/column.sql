-- Revert: schemas/routing_public/tables/domain_verifications/columns/verified_at/column


ALTER TABLE routing_public.domain_verifications 
  DROP COLUMN verified_at RESTRICT;