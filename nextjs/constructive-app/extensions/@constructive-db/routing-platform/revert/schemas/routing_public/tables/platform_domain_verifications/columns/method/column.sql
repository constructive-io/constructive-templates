-- Revert: schemas/routing_public/tables/platform_domain_verifications/columns/method/column


ALTER TABLE routing_public.platform_domain_verifications 
  DROP COLUMN method RESTRICT;