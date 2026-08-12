-- Revert: schemas/routing_public/tables/platform_api_settings/columns/api_id/column


ALTER TABLE routing_public.platform_api_settings 
  DROP COLUMN api_id RESTRICT;