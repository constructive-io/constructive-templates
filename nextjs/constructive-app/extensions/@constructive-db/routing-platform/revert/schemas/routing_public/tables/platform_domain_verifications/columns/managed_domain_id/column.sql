-- Revert: schemas/routing_public/tables/platform_domain_verifications/columns/managed_domain_id/column


ALTER TABLE routing_public.platform_domain_verifications 
  DROP COLUMN managed_domain_id RESTRICT;