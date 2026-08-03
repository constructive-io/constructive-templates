-- Revert: schemas/routing_public/tables/pubkey_settings/columns/user_field/alterations/alt0000000002


ALTER TABLE routing_public.pubkey_settings 
  ALTER COLUMN user_field DROP DEFAULT;