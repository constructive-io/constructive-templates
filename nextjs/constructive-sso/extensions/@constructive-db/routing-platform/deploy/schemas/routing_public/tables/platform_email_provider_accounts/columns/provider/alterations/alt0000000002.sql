-- Deploy: schemas/routing_public/tables/platform_email_provider_accounts/columns/provider/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_email_provider_accounts/columns/provider/column


COMMENT ON COLUMN routing_public.platform_email_provider_accounts.provider IS 'integration_providers.slug of the provider this account is at (mailgun, ses, postmark, smtp), matched by string not by FK';