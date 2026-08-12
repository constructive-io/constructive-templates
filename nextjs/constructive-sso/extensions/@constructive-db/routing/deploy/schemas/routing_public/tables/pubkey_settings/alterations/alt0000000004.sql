-- Deploy: schemas/routing_public/tables/pubkey_settings/alterations/alt0000000004
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/pubkey_settings/table


COMMENT ON TABLE routing_public.pubkey_settings IS '@scope database
@scopeKey database_id
@has_guard
@scopeTier database
Public-key crypto auth runtime configuration; typed references to the crypto sign-up/sign-in function plumbing';