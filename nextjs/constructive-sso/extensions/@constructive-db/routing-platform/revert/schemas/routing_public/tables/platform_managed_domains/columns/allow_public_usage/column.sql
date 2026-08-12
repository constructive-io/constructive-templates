-- Revert: schemas/routing_public/tables/platform_managed_domains/columns/allow_public_usage/column


ALTER TABLE routing_public.platform_managed_domains 
  DROP COLUMN allow_public_usage RESTRICT;