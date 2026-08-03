-- Revert: schemas/routing_public/tables/platform_domain_verifications/columns/updated_at/column


ALTER TABLE routing_public.platform_domain_verifications 
  DROP COLUMN updated_at RESTRICT;