-- Revert: schemas/routing_public/tables/database_settings/constraints/database_settings_pkey/constraint


ALTER TABLE routing_public.database_settings 
  DROP CONSTRAINT database_settings_pkey RESTRICT;