-- Revert: schemas/routing_public/tables/platform_managed_domains/columns/id/alterations/alt0000000002


ALTER TABLE routing_public.platform_managed_domains 
  ALTER COLUMN id DROP DEFAULT;