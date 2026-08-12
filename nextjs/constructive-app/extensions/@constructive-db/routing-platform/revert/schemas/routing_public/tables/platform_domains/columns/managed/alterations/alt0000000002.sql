-- Revert: schemas/routing_public/tables/platform_domains/columns/managed/alterations/alt0000000002


ALTER TABLE routing_public.platform_domains 
  ALTER COLUMN managed DROP DEFAULT;