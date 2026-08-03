-- Revert: schemas/routing_public/tables/platform_domain_verifications/columns/record_name/column


ALTER TABLE routing_public.platform_domain_verifications 
  DROP COLUMN record_name RESTRICT;