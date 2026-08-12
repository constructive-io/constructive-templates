-- Revert: schemas/routing_public/tables/platform_domain_verifications/columns/status/column


ALTER TABLE routing_public.platform_domain_verifications 
  DROP COLUMN status RESTRICT;