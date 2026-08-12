-- Deploy: schemas/routing_public/tables/pubkey_settings/columns/crypto_network/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/pubkey_settings/table
-- requires: schemas/routing_public/tables/pubkey_settings/columns/crypto_network/column


ALTER TABLE routing_public.pubkey_settings 
  ALTER COLUMN crypto_network SET DEFAULT 'cosmos';