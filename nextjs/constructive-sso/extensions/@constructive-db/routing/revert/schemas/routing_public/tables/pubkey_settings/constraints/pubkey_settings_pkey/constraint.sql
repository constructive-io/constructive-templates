-- Revert: schemas/routing_public/tables/pubkey_settings/constraints/pubkey_settings_pkey/constraint


ALTER TABLE routing_public.pubkey_settings 
  DROP CONSTRAINT pubkey_settings_pkey RESTRICT;