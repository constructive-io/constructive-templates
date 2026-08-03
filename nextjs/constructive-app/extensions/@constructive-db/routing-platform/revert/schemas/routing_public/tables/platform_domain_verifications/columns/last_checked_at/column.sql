-- Revert: schemas/routing_public/tables/platform_domain_verifications/columns/last_checked_at/column


ALTER TABLE routing_public.platform_domain_verifications 
  DROP COLUMN last_checked_at RESTRICT;