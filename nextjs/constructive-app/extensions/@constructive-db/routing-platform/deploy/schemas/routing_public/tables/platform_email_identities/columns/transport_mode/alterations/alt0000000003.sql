-- Deploy: schemas/routing_public/tables/platform_email_identities/columns/transport_mode/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_email_identities/columns/transport_mode/column


COMMENT ON COLUMN routing_public.platform_email_identities.transport_mode IS 'own = send through provider_account_id in this scope; platform_shared = send through the platform installation''s shared account, an explicit recorded choice and never an implicit fallback';