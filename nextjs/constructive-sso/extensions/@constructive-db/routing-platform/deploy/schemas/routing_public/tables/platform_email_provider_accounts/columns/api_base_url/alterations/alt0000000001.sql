-- Deploy: schemas/routing_public/tables/platform_email_provider_accounts/columns/api_base_url/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_email_provider_accounts/columns/api_base_url/column


COMMENT ON COLUMN routing_public.platform_email_provider_accounts.api_base_url IS 'Provider API base URL when it is not the provider default (e.g. Mailgun EU)';