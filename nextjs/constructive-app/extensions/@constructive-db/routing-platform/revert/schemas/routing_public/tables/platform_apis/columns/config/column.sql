-- Revert: schemas/routing_public/tables/platform_apis/columns/config/column


ALTER TABLE routing_public.platform_apis 
  DROP COLUMN config RESTRICT;