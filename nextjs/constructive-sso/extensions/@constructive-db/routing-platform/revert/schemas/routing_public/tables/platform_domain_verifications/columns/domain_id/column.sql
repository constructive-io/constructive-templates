-- Revert: schemas/routing_public/tables/platform_domain_verifications/columns/domain_id/column


ALTER TABLE routing_public.platform_domain_verifications 
  DROP COLUMN domain_id RESTRICT;