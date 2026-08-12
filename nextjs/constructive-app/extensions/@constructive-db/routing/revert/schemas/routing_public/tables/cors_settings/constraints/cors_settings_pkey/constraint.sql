-- Revert: schemas/routing_public/tables/cors_settings/constraints/cors_settings_pkey/constraint


ALTER TABLE routing_public.cors_settings 
  DROP CONSTRAINT cors_settings_pkey RESTRICT;