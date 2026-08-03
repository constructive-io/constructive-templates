-- Revert: schemas/routing_public/tables/platform_apis/columns/id/column


ALTER TABLE routing_public.platform_apis 
  DROP COLUMN id RESTRICT;