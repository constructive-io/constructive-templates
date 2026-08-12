-- Revert: schemas/routing_public/tables/platform_apis/columns/dbname/column


ALTER TABLE routing_public.platform_apis 
  DROP COLUMN dbname RESTRICT;