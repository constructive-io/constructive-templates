-- Deploy: schemas/routing_public/tables/email_provider_accounts/columns/credentials_secret_name/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/email_provider_accounts/columns/credentials_secret_name/column


COMMENT ON COLUMN routing_public.email_provider_accounts.credentials_secret_name IS 'Name of the secret holding this account''s API key or SMTP password. The value is resolved from the secret store at send time (realm = this row''s id) and is never stored here.';