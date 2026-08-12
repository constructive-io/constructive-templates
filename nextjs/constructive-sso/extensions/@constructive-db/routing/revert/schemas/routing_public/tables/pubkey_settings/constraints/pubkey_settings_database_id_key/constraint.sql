-- Revert: schemas/routing_public/tables/pubkey_settings/constraints/pubkey_settings_database_id_key/constraint


ALTER TABLE routing_public.pubkey_settings 
  DROP CONSTRAINT pubkey_settings_database_id_key RESTRICT;