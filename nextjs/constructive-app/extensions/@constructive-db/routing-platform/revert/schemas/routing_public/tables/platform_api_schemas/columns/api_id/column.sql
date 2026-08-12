-- Revert: schemas/routing_public/tables/platform_api_schemas/columns/api_id/column


ALTER TABLE routing_public.platform_api_schemas 
  DROP COLUMN api_id RESTRICT;