-- Deploy: schemas/routing_public/tables/email_provider_accounts/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/email_provider_accounts/table


COMMENT ON TABLE routing_public.email_provider_accounts IS '@scope database
@scopeKey database_id
@scopeTier database
A tenant''s configured account at an email provider: provider slug, endpoint coordinates, and the NAME of the secret holding its credentials (never the credential itself)';