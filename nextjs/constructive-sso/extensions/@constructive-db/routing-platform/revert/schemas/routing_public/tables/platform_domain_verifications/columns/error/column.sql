-- Revert: schemas/routing_public/tables/platform_domain_verifications/columns/error/column


ALTER TABLE routing_public.platform_domain_verifications 
  DROP COLUMN error RESTRICT;