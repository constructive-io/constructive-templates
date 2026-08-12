-- Deploy: schemas/routing_public/tables/platform_email_provider_accounts/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_email_provider_accounts/table


COMMENT ON TABLE routing_public.platform_email_provider_accounts IS 'A tenant''s configured account at an email provider: provider slug, endpoint coordinates, and the NAME of the secret holding its credentials (never the credential itself)';