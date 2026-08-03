-- Revert: schemas/routing_public/tables/domain_verifications/columns/expires_at/column


ALTER TABLE routing_public.domain_verifications 
  DROP COLUMN expires_at RESTRICT;