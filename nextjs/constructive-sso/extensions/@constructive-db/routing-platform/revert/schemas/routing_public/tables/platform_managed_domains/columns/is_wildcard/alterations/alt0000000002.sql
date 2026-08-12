-- Revert: schemas/routing_public/tables/platform_managed_domains/columns/is_wildcard/alterations/alt0000000002


ALTER TABLE routing_public.platform_managed_domains 
  ALTER COLUMN is_wildcard DROP DEFAULT;