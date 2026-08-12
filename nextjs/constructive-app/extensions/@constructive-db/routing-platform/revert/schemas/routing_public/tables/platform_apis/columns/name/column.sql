-- Revert: schemas/routing_public/tables/platform_apis/columns/name/column


ALTER TABLE routing_public.platform_apis 
  DROP COLUMN name RESTRICT;