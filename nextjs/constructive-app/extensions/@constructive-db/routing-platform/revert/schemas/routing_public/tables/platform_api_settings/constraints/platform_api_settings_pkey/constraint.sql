-- Revert: schemas/routing_public/tables/platform_api_settings/constraints/platform_api_settings_pkey/constraint


ALTER TABLE routing_public.platform_api_settings 
  DROP CONSTRAINT platform_api_settings_pkey RESTRICT;