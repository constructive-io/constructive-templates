-- Revert: schemas/routing_public/tables/platform_apis/columns/is_published/column


ALTER TABLE routing_public.platform_apis 
  DROP COLUMN is_published RESTRICT;