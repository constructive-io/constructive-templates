-- Deploy: schemas/routing_public/tables/platform_email_provider_accounts/columns/region/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_email_provider_accounts/columns/region/column


COMMENT ON COLUMN routing_public.platform_email_provider_accounts.region IS 'Provider region for region-addressed providers (e.g. SES us-east-1)';