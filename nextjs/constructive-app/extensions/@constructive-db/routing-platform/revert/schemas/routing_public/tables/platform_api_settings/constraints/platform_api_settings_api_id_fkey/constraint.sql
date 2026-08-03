-- Revert: schemas/routing_public/tables/platform_api_settings/constraints/platform_api_settings_api_id_fkey/constraint


ALTER TABLE routing_public.platform_api_settings 
  DROP CONSTRAINT platform_api_settings_api_id_fkey RESTRICT;