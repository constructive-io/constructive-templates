-- Revert: schemas/routing_public/tables/domain_verifications/columns/created_at/column


ALTER TABLE routing_public.domain_verifications 
  DROP COLUMN created_at RESTRICT;