-- Revert: schemas/routing_public/tables/platform_api_settings/columns/enable_realtime/column


ALTER TABLE routing_public.platform_api_settings 
  DROP COLUMN enable_realtime RESTRICT;