-- Deploy: schemas/routing_public/tables/pubkey_settings/columns/crypto_network/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/pubkey_settings/columns/crypto_network/column


COMMENT ON COLUMN routing_public.pubkey_settings.crypto_network IS 'Crypto network for key derivation (e.g. cosmos, ethereum)';