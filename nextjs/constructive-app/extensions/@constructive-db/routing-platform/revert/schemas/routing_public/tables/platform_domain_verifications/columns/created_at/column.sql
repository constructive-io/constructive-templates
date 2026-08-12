-- Revert: schemas/routing_public/tables/platform_domain_verifications/columns/created_at/column


ALTER TABLE routing_public.platform_domain_verifications 
  DROP COLUMN created_at RESTRICT;