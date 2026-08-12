-- Revert: schemas/routing_public/tables/platform_managed_domains/columns/is_wildcard/column


ALTER TABLE routing_public.platform_managed_domains 
  DROP COLUMN is_wildcard RESTRICT;