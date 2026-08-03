-- Revert: schemas/routing_public/tables/platform_domains/columns/is_published/column


ALTER TABLE routing_public.platform_domains 
  DROP COLUMN is_published RESTRICT;