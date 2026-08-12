-- Revert: schemas/routing_public/tables/platform_domains/columns/is_wildcard/column


ALTER TABLE routing_public.platform_domains 
  DROP COLUMN is_wildcard RESTRICT;