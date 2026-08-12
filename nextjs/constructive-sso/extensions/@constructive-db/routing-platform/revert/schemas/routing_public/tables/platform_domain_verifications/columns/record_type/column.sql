-- Revert: schemas/routing_public/tables/platform_domain_verifications/columns/record_type/column


ALTER TABLE routing_public.platform_domain_verifications 
  DROP COLUMN record_type RESTRICT;