-- Revert: schemas/routing_public/tables/rls_settings/constraints/rls_settings_pkey/constraint


ALTER TABLE routing_public.rls_settings 
  DROP CONSTRAINT rls_settings_pkey RESTRICT;