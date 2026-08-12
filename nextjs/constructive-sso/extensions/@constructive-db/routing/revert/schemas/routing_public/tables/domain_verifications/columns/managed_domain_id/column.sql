-- Revert: schemas/routing_public/tables/domain_verifications/columns/managed_domain_id/column


ALTER TABLE routing_public.domain_verifications 
  DROP COLUMN managed_domain_id RESTRICT;