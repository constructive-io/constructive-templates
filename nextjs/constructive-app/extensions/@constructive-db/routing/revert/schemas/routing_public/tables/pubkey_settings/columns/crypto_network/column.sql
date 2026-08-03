-- Revert: schemas/routing_public/tables/pubkey_settings/columns/crypto_network/column


ALTER TABLE routing_public.pubkey_settings 
  DROP COLUMN crypto_network RESTRICT;