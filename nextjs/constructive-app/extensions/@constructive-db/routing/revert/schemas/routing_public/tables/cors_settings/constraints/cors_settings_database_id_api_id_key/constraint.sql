-- Revert: schemas/routing_public/tables/cors_settings/constraints/cors_settings_database_id_api_id_key/constraint


ALTER TABLE routing_public.cors_settings 
  DROP CONSTRAINT cors_settings_database_id_api_id_key RESTRICT;