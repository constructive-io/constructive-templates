-- Revert: schemas/routing_public/tables/platform_domain_verifications/columns/expires_at/column


ALTER TABLE routing_public.platform_domain_verifications 
  DROP COLUMN expires_at RESTRICT;