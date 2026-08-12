-- Deploy: schemas/routing_public/tables/platform_email_provider_accounts/indexes/platform_email_provider_accounts_created_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_email_provider_accounts/table
-- requires: schemas/routing_public/tables/platform_email_provider_accounts/columns/created_at/column


CREATE INDEX platform_email_provider_accounts_created_at_idx ON routing_public.platform_email_provider_accounts (created_at);