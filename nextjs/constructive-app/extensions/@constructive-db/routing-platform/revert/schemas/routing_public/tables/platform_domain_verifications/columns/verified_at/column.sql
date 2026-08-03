-- Revert: schemas/routing_public/tables/platform_domain_verifications/columns/verified_at/column


ALTER TABLE routing_public.platform_domain_verifications 
  DROP COLUMN verified_at RESTRICT;