-- Revert: schemas/routing_public/tables/platform_managed_domains/columns/verification_status/column


ALTER TABLE routing_public.platform_managed_domains 
  DROP COLUMN verification_status RESTRICT;