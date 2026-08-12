-- Deploy: schemas/routing_public/tables/platform_email_provider_accounts/columns/webhook_signing_secret_name/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_email_provider_accounts/columns/webhook_signing_secret_name/column


COMMENT ON COLUMN routing_public.platform_email_provider_accounts.webhook_signing_secret_name IS 'Name of the secret used to verify this provider''s delivery/bounce webhooks. Name only; the value stays in the secret store.';