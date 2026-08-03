-- Revert: schemas/routing_public/tables/platform_api_settings/columns/enable_i18n/column


ALTER TABLE routing_public.platform_api_settings 
  DROP COLUMN enable_i18n RESTRICT;