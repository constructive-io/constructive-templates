-- Deploy: schemas/routing_public/tables/platform_email_provider_accounts/columns/smtp_host/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_email_provider_accounts/columns/smtp_host/column


COMMENT ON COLUMN routing_public.platform_email_provider_accounts.smtp_host IS 'SMTP host (provider = smtp, or a provider addressed over SMTP)';