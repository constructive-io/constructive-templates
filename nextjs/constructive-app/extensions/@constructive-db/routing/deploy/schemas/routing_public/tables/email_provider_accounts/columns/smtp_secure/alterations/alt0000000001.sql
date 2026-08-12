-- Deploy: schemas/routing_public/tables/email_provider_accounts/columns/smtp_secure/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/email_provider_accounts/columns/smtp_secure/column


COMMENT ON COLUMN routing_public.email_provider_accounts.smtp_secure IS 'Whether the SMTP connection uses implicit TLS';