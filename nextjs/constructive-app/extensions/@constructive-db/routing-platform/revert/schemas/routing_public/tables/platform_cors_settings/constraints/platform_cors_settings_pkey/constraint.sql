-- Revert: schemas/routing_public/tables/platform_cors_settings/constraints/platform_cors_settings_pkey/constraint


ALTER TABLE routing_public.platform_cors_settings 
  DROP CONSTRAINT platform_cors_settings_pkey RESTRICT;