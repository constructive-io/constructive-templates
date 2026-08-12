-- Revert: schemas/routing_public/tables/platform_managed_domains/columns/verification_status/alterations/alt0000000002


ALTER TABLE routing_public.platform_managed_domains 
  ALTER COLUMN verification_status DROP DEFAULT;