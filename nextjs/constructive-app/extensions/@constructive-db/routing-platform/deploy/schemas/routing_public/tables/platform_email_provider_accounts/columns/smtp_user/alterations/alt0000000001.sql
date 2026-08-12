-- Deploy: schemas/routing_public/tables/platform_email_provider_accounts/columns/smtp_user/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_email_provider_accounts/columns/smtp_user/column


COMMENT ON COLUMN routing_public.platform_email_provider_accounts.smtp_user IS 'SMTP username; the password is a secret, addressed by credentials_secret_name';