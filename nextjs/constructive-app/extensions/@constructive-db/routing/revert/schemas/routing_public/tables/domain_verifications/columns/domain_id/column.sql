-- Revert: schemas/routing_public/tables/domain_verifications/columns/domain_id/column


ALTER TABLE routing_public.domain_verifications 
  DROP COLUMN domain_id RESTRICT;