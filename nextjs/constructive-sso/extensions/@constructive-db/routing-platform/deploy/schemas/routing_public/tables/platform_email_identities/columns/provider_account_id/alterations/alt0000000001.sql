-- Deploy: schemas/routing_public/tables/platform_email_identities/columns/provider_account_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_email_identities/columns/provider_account_id/column


COMMENT ON COLUMN routing_public.platform_email_identities.provider_account_id IS 'Same-scope provider account this identity sends through. Required for transport_mode = own, NULL for platform_shared.';