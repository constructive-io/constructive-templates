-- Revert: schemas/routing_public/tables/cors_settings/constraints/cors_settings_api_id_fkey/constraint


ALTER TABLE routing_public.cors_settings 
  DROP CONSTRAINT cors_settings_api_id_fkey RESTRICT;