-- Revert: schemas/routing_public/tables/platform_api_settings/columns/options/column


ALTER TABLE routing_public.platform_api_settings 
  DROP COLUMN options RESTRICT;