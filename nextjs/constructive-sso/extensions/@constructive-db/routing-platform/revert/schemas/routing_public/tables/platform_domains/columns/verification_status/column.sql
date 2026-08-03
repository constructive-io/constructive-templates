-- Revert: schemas/routing_public/tables/platform_domains/columns/verification_status/column


ALTER TABLE routing_public.platform_domains 
  DROP COLUMN verification_status RESTRICT;