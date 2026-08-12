-- Revert: schemas/routing_public/tables/pubkey_settings/columns/crypto_network/alterations/alt0000000002


ALTER TABLE routing_public.pubkey_settings 
  ALTER COLUMN crypto_network DROP DEFAULT;