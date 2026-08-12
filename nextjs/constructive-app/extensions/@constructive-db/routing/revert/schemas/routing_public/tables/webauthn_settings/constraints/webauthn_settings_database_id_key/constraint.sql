-- Revert: schemas/routing_public/tables/webauthn_settings/constraints/webauthn_settings_database_id_key/constraint


ALTER TABLE routing_public.webauthn_settings 
  DROP CONSTRAINT webauthn_settings_database_id_key RESTRICT;