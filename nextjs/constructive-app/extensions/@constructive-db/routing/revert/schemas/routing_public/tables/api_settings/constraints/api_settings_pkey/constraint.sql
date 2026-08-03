-- Revert: schemas/routing_public/tables/api_settings/constraints/api_settings_pkey/constraint


ALTER TABLE routing_public.api_settings 
  DROP CONSTRAINT api_settings_pkey RESTRICT;