-- Revert: schemas/routing_public/tables/platform_domain_verifications/columns/attempts/column


ALTER TABLE routing_public.platform_domain_verifications 
  DROP COLUMN attempts RESTRICT;