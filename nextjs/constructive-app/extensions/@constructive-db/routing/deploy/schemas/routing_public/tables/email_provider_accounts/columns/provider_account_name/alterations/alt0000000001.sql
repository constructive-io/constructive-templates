-- Deploy: schemas/routing_public/tables/email_provider_accounts/columns/provider_account_name/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/email_provider_accounts/columns/provider_account_name/column


COMMENT ON COLUMN routing_public.email_provider_accounts.provider_account_name IS 'Account identifier at the provider — the Mailgun sending domain, the SES verified identity, the Postmark server name';